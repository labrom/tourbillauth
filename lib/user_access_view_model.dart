import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:tourbillon/cache.dart';
import 'package:tourbillon/data_provider.dart';
import 'package:tourbillon/firestore.dart';

import 'app_user.dart';

/// A view model that allows to manage the app's users.
///
/// This implementation of stores users in a Firestore collection, and resource
/// user roles in an array field in the resource document (this resource document
/// might be the actual resource document, or another document that is associated
/// this resource - with the same id - and only contains user roles for this resource).
///
/// This class doesn't perform any verification of the current user's role. If the
/// current user doesn't have sufficient rights to manage other users, this view
/// model shouldn't be used.
///
/// Adding users or invitations:
/// Users are stored in the `users` collection by default (a different name can
/// be specified), where document IDs are the user's UID. Documents contain a
/// mandatory `email` field and two optional `role` and `display` fields.
/// Invitations are stored in the `invites` collection by default (a different
/// name can be specified), where document IDs are the user's email address.
/// Documents contain an optional `role` field.
/// In both collections, the `role` field is a string array that contains the
/// list of roles this user (or invited user) has.
/// In both cases, if a resource path is specified, the corresponding document's
/// `roles` field is also updated, with the expectation that his field is a
/// nested object whose keys are either UIDs or email addresses, and values are
/// corresponding user's roles.
///
/// The source of truth for access to resources is the `users` table. If a
/// resource lists a role for a user, this user must also be present in the
/// `users` table in order to have access to this resource.
class UserAccessViewModel with ChangeNotifier {
  final BuildContext _context;
  final DataProvider _userProvider;
  final String userCollectionName;
  final DataProvider _inviteProvider;
  final String inviteCollectionName;
  final Cache<DocumentSnapshot> _resourceCache = Cache();

  UserAccessViewModel(
    this._context, {
    this.userCollectionName = 'users',
    this.inviteCollectionName = 'invites',
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

  void addInvite(String email, {String? resource, String? role}) {
    var addInvite = firestoreProvider(_context)
        .instance
        .collection(inviteCollectionName)
        .doc(email)
        .set({
      'role': role,
    });
    if (resource != null) {
      Future.wait([
        addInvite,
        FirebaseFirestore.instance.doc(resource).update({
          'roles.$email': role,
        }),
      ]).then((_) {
        _resourceCache.setStale(resource);
        notifyListeners();
      });
    } else {
      addInvite.then((_) => notifyListeners());
    }
  }

  void addUser(String userId,
      {required String email, String? resource, String? role}) {
    var addUser = firestoreProvider(_context)
        .instance
        .collection(userCollectionName)
        .doc(userId)
        .set({
      'email': email,
      'role': role,
    });
    if (resource != null) {
      Future.wait([
        addUser,
        FirebaseFirestore.instance.doc(resource).update({
          'roles.$userId': role,
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
    var invites = _inviteProvider.data
        .map((doc) => InviteRole(
              doc.id,
              role: doc.getOrNull('role'),
            ))
        .toList();

    if (resource != null) {
      var doc = _resourceCache[resource];
      if (doc != null) {
        var resourceUsers = doc.getOrDefault<Map<String, dynamic>>('roles', {});
        invites
            .removeWhere((user) => !resourceUsers.containsKey(user.userEmail));
        for (var invite in invites) {
          invite.role = resourceUsers[invite.userEmail];
        }
      } else {
        firestoreProvider(_context).instance.doc(resource).get().then((doc) {
          _resourceCache[resource] = doc;
          notifyListeners();
        });
      }
    }
    return invites;
  }

  List<AppUserRole> listUsers({String? resource}) {
    var users = _userProvider.data
        .map((doc) => AppUserRole(
              doc.id,
              doc.get('email'),
              userDisplay: doc.getOrNull('display'),
              role: doc.getOrNull('role'),
            ))
        .toList();

    if (resource != null) {
      var doc = _resourceCache[resource];
      if (doc != null) {
        var resourceUsers = doc.getOrDefault<Map<String, dynamic>>('roles', {});
        users.removeWhere((user) => !resourceUsers.containsKey(user.uid));
        for (var user in users) {
          user.role = resourceUsers[user.uid];
        }
      } else {
        firestoreProvider(_context).instance.doc(resource).get().then((doc) {
          _resourceCache[resource] = doc;
          notifyListeners();
        });
      }
    }
    return users;
  }

  List<UserRole> listUsersAndInvites({String? resource}) {
    var users = listUsers(resource: resource);
    var userEmails = users.map((user) => user.userEmail).toList();
    var usersAndInvites = List<UserRole>.from(users);
    usersAndInvites.addAll(listInvites(resource: resource)
        .where((invite) => !userEmails.contains(invite.userEmail)));
    usersAndInvites
        .sort((email1, email2) => email1.userEmail.compareTo(email2.userEmail));
    return usersAndInvites;
  }

  void removeInvite(String email, {String? resource}) {
    _inviteProvider.delete(email);
    // Expect resource roles to be automatically deleted with a Firestore function.
  }

  void removeUser(String userId, {String? resource}) {
    _userProvider.delete(userId);
    // Expect resource roles to be automatically deleted with a Firestore function.
  }
}

mixin UserRole {
  late String userEmail;
  late String? role;
  String? get userId;
}

class AppUserRole extends AppUser with UserRole {
  AppUserRole(
    String userId,
    String userEmail, {
    String? userDisplay,
    String? role,
  }) : super(
            uid: userId,
            email: userEmail,
            description: userDisplay ?? userEmail) {
    this.userEmail = userEmail;
    this.role = role;
  }

  @override
  String? get userId => uid;
}

class InviteRole with UserRole {
  InviteRole(
    String userEmail, {
    String? role,
  }) {
    this.userEmail = userEmail;
    this.role = role;
  }

  @override
  String? get userId => null;
}
