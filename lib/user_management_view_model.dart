import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:tourbillon/data_provider.dart';
import 'package:tourbillon/firestore.dart';

abstract class UserManagementViewModel extends ChangeNotifier {
  /// Creates a [FirestoreUserManagementViewModel].
  factory UserManagementViewModel.firestore(BuildContext context) =>
      FirestoreUserManagementViewModel(context);

  List<UserRole> listUsers({String? resource});

  List<InviteRole> listInvites({String? resource});

  Future<void> addUser(String userId,
      {required String email, String? resource, String? role});

  Future<void> addInvite(String email, {String? resource, String? role});

  Future<void> removeUser(String userId, {String? resource});

  Future<void> removeInvite(String email, {String? resource});
}

class UserRole {
  final String userId;
  final String userEmail;
  final String userDisplay;
  final String? role;

  UserRole(
    this.userId,
    this.userEmail, {
    String? userDisplay,
    this.role,
  }) : this.userDisplay = userDisplay ?? userEmail;
}

class InviteRole {
  final String userEmail;
  final String? role;

  InviteRole(
    this.userEmail, {
    this.role,
  });
}

/// An implementation of [UserManagementViewModel] that stores users in a
/// Firestore table, and resource user roles in an array field in the
/// resource document.
///
/// Adding user or invitations:
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
class FirestoreUserManagementViewModel
    with ChangeNotifier
    implements UserManagementViewModel {
  final BuildContext _context;
  final DataProvider _userProvider;
  final DataProvider _inviteProvider;

  FirestoreUserManagementViewModel(this._context)
      : _userProvider = DataProvider(_context, 'users'),
        _inviteProvider = DataProvider(_context, 'invites') {
    _userProvider.addListener(() => notifyListeners());
    _inviteProvider.addListener(() => notifyListeners());
  }

  @override
  Future<void> addInvite(String email, {String? resource, String? role}) async {
    await firestoreProvider(_context)
        .instance
        .collection('invites')
        .doc(email)
        .set({
      'role': role,
    });
    if (resource != null) {
      await FirebaseFirestore.instance.doc(resource).update({
        'roles.$email': role,
      });
    }
  }

  @override
  Future<void> addUser(String userId,
      {required String email, String? resource, String? role}) async {
    await firestoreProvider(_context)
        .instance
        .collection('users')
        .doc(userId)
        .set({
      'email': email,
      'role': role,
    });
    if (resource != null) {
      await FirebaseFirestore.instance.doc(resource).update({
        'roles.$userId': role,
      });
    }
  }

  @override
  List<InviteRole> listInvites({String? resource}) => _inviteProvider.data
      .map((doc) => InviteRole(
            doc.id,
            role: doc.getOrNull('role'),
          ))
      .toList();

  @override
  List<UserRole> listUsers({String? resource}) => _userProvider.data
      .map((doc) => UserRole(
            doc.id,
            doc.get('email'),
            userDisplay: doc.getOrNull('display'),
            role: doc.getOrNull('role'),
          ))
      .toList();

  @override
  Future<void> removeInvite(String email, {String? resource}) async {
    await firestoreProvider(_context)
        .instance
        .collection('invites')
        .doc(email)
        .delete();
    // Expect resource roles to be automatically deleted with a Firestore function.
  }

  @override
  Future<void> removeUser(String userId, {String? resource}) async {
    await firestoreProvider(_context)
        .instance
        .collection('users')
        .doc(userId)
        .delete();
    // Expect resource roles to be automatically deleted with a Firestore function.
  }
}
