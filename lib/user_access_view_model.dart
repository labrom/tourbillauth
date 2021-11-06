import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:tourbillon/cache.dart';
import 'package:tourbillon/data_provider.dart';
import 'package:tourbillon/firestore.dart';
import 'package:tourbillon/log.dart';

import 'app_user.dart';

/// A view model that allows to manage the app's users.
///
/// This implementation of stores users in a Firestore collection, and resource
/// user roles in a set of fields in the resource document. This resource document
/// might be the actual resource document, or another document that is associated
/// with this resource - with the same id - and only contains user roles for this
/// resource. When working with a resource, a user or invited user only has access
/// to this resource when the document contains a field for this user or invite.
/// This field contains the list of roles specific to this resource, for the associated
/// user or invite. This field name's format is `roles:xxx` where `xxx` is either
/// the user's UID or the document ID of the invite.
/// If the list is empty, the user or invite still has access,
/// but their role(s) default to the ones specified in the user or invite document.
///
/// This class doesn't perform any verification of the current user's role. If the
/// current user doesn't have sufficient rights to manage other users, this view
/// model shouldn't be used.
///
/// Adding users or invitations:
/// Users are stored in the `users` collection by default (a different name can
/// be specified), where document IDs are the user's UID. Documents contain a
/// mandatory `email` field and two optional `roles` (a different name can be
/// specified) and `display` fields.
/// Invitations are stored in the `invites` collection by default (a different
/// name can be specified), where document IDs are auto-generated.
/// Documents contain a mandatory `email` field  an optional `roles` field
/// (a different name can be specified).
/// In both collections, the `roles` field is a string array that contains the
/// list of roles this user (or invited user) has.
///
/// In both cases, if a resource path is specified, the corresponding document's
/// `roles:xxx` field is also updated with the list of roles.
///
/// The source of truth for access to resources is the user list. If a
/// resource lists a role for a user, this user must also be present in the
/// user list in order to have access to this resource.
class UserAccessViewModel with ChangeNotifier {
  final BuildContext _context;
  final DataProvider _userProvider;
  final String userCollectionName;
  final DataProvider _inviteProvider;
  final String inviteCollectionName;
  final String rolesFieldName;
  final Cache<DocumentSnapshot> _resourceCache = Cache();

  UserAccessViewModel(
    this._context, {
    this.userCollectionName = 'users',
    this.inviteCollectionName = 'invites',
    this.rolesFieldName = 'roles',
  })  : _userProvider = DataProvider(
          _context,
          userCollectionName,
          queryModifier: (query) => query.orderBy('email'),
        ),
        _inviteProvider = DataProvider(
          _context,
          inviteCollectionName,
          queryModifier: (query) => query.orderBy(FieldPath.documentId),
        ) {
    _userProvider.addListener(() => notifyListeners());
    _inviteProvider.addListener(() => notifyListeners());
  }

  void addInvite(String email,
      {String? resource, List<String> roles = const []}) {
    var addInvite = firestoreProvider(_context)
        .instance
        .collection(inviteCollectionName)
        .add({
      'email': email,
      rolesFieldName: FieldValue.arrayUnion(roles),
    });
    if (resource != null) {
      addInvite.then((inviteDoc) {
        FirebaseFirestore.instance.doc(resource).update({
          '$rolesFieldName:$inviteDoc.id': roles,
        }).then((_) {
          _resourceCache.setStale(resource);
          notifyListeners();
        });
      });
    } else {
      addInvite.then((_) => notifyListeners());
    }
  }

  void addUser(String userId,
      {required String email,
      String? resource,
      List<String> roles = const []}) {
    var addUser = firestoreProvider(_context)
        .instance
        .collection(userCollectionName)
        .doc(userId)
        .set({
      'email': email,
      rolesFieldName: FieldValue.arrayUnion(roles),
    }, SetOptions(merge: true));
    if (resource != null) {
      Future.wait([
        addUser,
        FirebaseFirestore.instance.doc(resource).update({
          '$rolesFieldName:$userId': roles,
        }),
      ]).then((_) {
        _resourceCache.setStale(resource);
        notifyListeners();
      });
    } else {
      addUser.then((_) => notifyListeners());
    }
  }

  List<InviteRole> listInvites({String? resource}) {
    final invites = _inviteProvider.data
        .map((doc) => InviteRole(
              userEmail: doc.get('email'),
              docId: doc.id,
              roles: doc.getListOf<String>(rolesFieldName),
            ))
        .toList();
    if (resource == null) {
      return invites;
    }

    // If there is a non-stale resource doc in the cache, load roles of users
    // that are on the invite list
    var resourceDoc = _resourceCache[resource];
    if (resourceDoc != null) {
      // Check if resource doc has a roles entry for this invite
      // This role entry can be an empty role list
      // If there is no entry (different from empty list), the invite is removed
      final resourceData = resourceDoc.data() as Map<String, dynamic>;
      invites.removeWhere((invite) =>
          !resourceData.containsKey('$rolesFieldName:${invite.docId}'));
      for (var invite in invites) {
        final resourceInviteRoles =
            resourceDoc.getListOf<String>('$rolesFieldName:${invite.docId}');
        // Replace invite roles with resource roles if it isn't empty.
        if (resourceInviteRoles.isNotEmpty) {
          invite.roles.clear();
          invite.roles.addAll(resourceInviteRoles);
        }
      }
      return invites;
    }

    // Resource doc isn't in the cache, so load it, and return an empty invite list
    _loadResource(resource);
    return List.empty();
  }

  List<AppUserRole> listUsers({String? resource}) {
    final users = _userProvider.data
        .map((doc) => AppUserRole(
              doc.id,
              doc.get('email'),
              userDisplay: doc.getOrNull('display'),
              roles: doc.getListOf<String>(rolesFieldName),
            ))
        .toList();
    if (resource == null) {
      return users;
    }

    // If there is a non-stale resource doc in the cache, load roles of users
    // that are on the user list
    var resourceDoc = _resourceCache[resource];
    if (resourceDoc != null) {
      // Check if resource doc has a roles entry for this user
      // This role entry can be an empty role list
      // If there is no entry (different from empty list), the user is removed
      var resourceData = resourceDoc.data() as Map<String, dynamic>;
      users.removeWhere((user) =>
          !resourceData.containsKey('$rolesFieldName:${user.userId}'));
      for (var user in users) {
        final resourceUserRoles =
            resourceDoc.getListOf<String>('$rolesFieldName:${user.userId}');
        // Replace user roles with resource roles if it isn't empty.
        if (resourceUserRoles.isNotEmpty) {
          user.roles.clear();
          user.roles.addAll(resourceUserRoles);
        }
      }
      return users;
    }

    // Resource doc isn't in the cache, so load it, and return an empty invite list
    _loadResource(resource);
    return List.empty();
  }

  void _loadResource(String resource) {
    // TODO Only load roles
    firestoreProvider(_context).instance.doc(resource).get().then((doc) {
      _resourceCache[resource] = doc;
      notifyListeners();
    });
  }

  List<UserRole> listUsersAndInvites({String? resource}) {
    final users = listUsers(resource: resource);
    final invites = listInvites(resource: resource);
    final userEmails = users.map((user) => user.userEmail).toList();
    final inviteEmails = invites.map((invite) => invite.userEmail).toList();
    final invitesOnly =
        invites.where((invite) => !userEmails.contains(invite.userEmail));
    final mergeableUsers =
        users.where((user) => inviteEmails.contains(user.userEmail));
    final mergeableInvites =
        invites.where((invite) => userEmails.contains(invite.userEmail));

    // Merge roles from user and invite entries with the same email address
    for (var userInvite in mergeableUsers) {
      userInvite.roles.addAll(mergeableInvites
          .firstWhere((invite) => invite.userEmail == userInvite.userEmail)
          .roles);
    }
    // Add invites to user list
    final usersAndInvites = List<UserRole>.from(users);
    usersAndInvites.addAll(invitesOnly);
    usersAndInvites
        .sort((email1, email2) => email1.userEmail.compareTo(email2.userEmail));
    return usersAndInvites;
  }

  void removeInvite(String email, {String? resource}) {
    try {
      final inviteDoc =
          _inviteProvider.data.firstWhere((doc) => doc.get('email') == email);
      _inviteProvider.delete(inviteDoc.id);
      // Expect resource roles to be automatically deleted with a Firestore function.
    } on StateError {
      log.i('No invite found for $email');
    }
  }

  void removeUser(String userId, {String? resource}) {
    _userProvider.delete(userId);
    // Expect resource roles to be automatically deleted with a Firestore function.
  }
}

mixin UserRole {
  /// User's email address.
  late String userEmail;

  /// Set of user's roles.
  ///
  /// Roles are sorted in alphabetical order.
  final Set<String> roles = SplayTreeSet();

  /// User's Firebase UID.
  String? get userId;
}

class AppUserRole extends AppUser with UserRole {
  AppUserRole(
    String userId,
    String userEmail, {
    String? userDisplay,
    List<String>? roles,
  }) : super(
            uid: userId,
            email: userEmail,
            description: userDisplay ?? userEmail) {
    this.userEmail = userEmail;
    if (roles != null) {
      this.roles.addAll(roles);
    }
  }

  @override
  String? get userId => uid;
}

class InviteRole with UserRole {
  String? docId;
  InviteRole({
    required String userEmail,
    this.docId,
    List<String>? roles,
  }) {
    this.userEmail = userEmail;
    if (roles != null) {
      this.roles.addAll(roles);
    }
  }

  @override
  String? get userId => null;
}
