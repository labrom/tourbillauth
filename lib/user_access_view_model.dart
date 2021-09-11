import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:tourbillon/cache.dart';
import 'package:tourbillon/data_provider.dart';
import 'package:tourbillon/firestore.dart';

import 'app_user.dart';

abstract class UserAccessViewModel extends ChangeNotifier {
  /// Creates a [FirestoreUserAccessViewModel].
  factory UserAccessViewModel.firestore(BuildContext context) =>
      FirestoreUserAccessViewModel(context);

  List<AppUserRole> listUsers({String? resource});

  List<InviteRole> listInvites({String? resource});

  List<UserRole> listUsersAndInvites({String? resource});

  void addUser(String userId,
      {required String email, String? resource, String? role});

  void addInvite(String email, {String? resource, String? role});

  void removeUser(String userId, {String? resource});

  void removeInvite(String email, {String? resource});
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

/// An implementation of [UserAccessViewModel] that stores users in a
/// Firestore table, and resource user roles in an array field in the
/// resource document.
///
/// Adding users or invitations:
/// Users are stored in the `users` table, where document IDs are the user's
/// UID. Documents contain a mandatory `email` field and an optional `role`
/// field.
/// Invitations are stored in the `invites` table, where document IDs are the
/// user's email address. Documents contain an optional `role` field.
/// In both cases, if a resource path is specified, the corresponding document's
/// `roles` field is also updated, with the expectation that his field is a
/// nested object whose keys are either UIDs or email addresses, and values are
/// corresponding user's roles.
///
/// The source of truth for access to resources is the `users` table. If a
/// resource lists a role for a user, this user must also be present in the
/// `users` table in order to have access to this resource.
class FirestoreUserAccessViewModel
    with ChangeNotifier
    implements UserAccessViewModel {
  final BuildContext _context;
  final DataProvider _userProvider;
  final DataProvider _inviteProvider;
  final Cache<DocumentSnapshot> _resourceCache = Cache();

  FirestoreUserAccessViewModel(this._context)
      : _userProvider = DataProvider(
          _context,
          'users',
          queryModifier: (query) => query.orderBy('email'),
        ),
        _inviteProvider = DataProvider(
          _context,
          'invites',
          queryModifier: (query) => query.orderBy(FieldPath.documentId),
        ) {
    _userProvider.addListener(() => notifyListeners());
    _inviteProvider.addListener(() => notifyListeners());
  }

  @override
  void addInvite(String email, {String? resource, String? role}) {
    var addInvite = firestoreProvider(_context)
        .instance
        .collection('invites')
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

  @override
  void addUser(String userId,
      {required String email, String? resource, String? role}) {
    var addUser = firestoreProvider(_context)
        .instance
        .collection('users')
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

  @override
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

  @override
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

  @override
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

  @override
  void removeInvite(String email, {String? resource}) {
    _inviteProvider.delete(email);
    // Expect resource roles to be automatically deleted with a Firestore function.
  }

  @override
  void removeUser(String userId, {String? resource}) {
    _userProvider.delete(userId);
    // Expect resource roles to be automatically deleted with a Firestore function.
  }
}
