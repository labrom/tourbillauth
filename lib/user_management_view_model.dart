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

  List<EmailRole> listUsersAndInvites({String? resource});

  Future<void> addUser(String userId,
      {required String email, String? resource, String? role});

  Future<void> addInvite(String email, {String? resource, String? role});

  Future<void> removeUser(String userId, {String? resource});

  Future<void> removeInvite(String email, {String? resource});
}

mixin EmailRole {
  late String userEmail;
  late String? role;
}

class UserRole with EmailRole {
  final String userId;
  final String userDisplay;

  UserRole(
    this.userId,
    String userEmail, {
    String? userDisplay,
    String? role,
  }) : userDisplay = userDisplay ?? userEmail {
    this.userEmail = userEmail;
    this.role = role;
  }
}

class InviteRole with EmailRole {
  InviteRole(
    String userEmail, {
    String? role,
  }) {
    this.userEmail = userEmail;
    this.role = role;
  }
}

/// An implementation of [UserManagementViewModel] that stores users in a
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
class FirestoreUserManagementViewModel
    with ChangeNotifier
    implements UserManagementViewModel {
  final BuildContext _context;
  final DataProvider _userProvider;
  final DataProvider _inviteProvider;

  FirestoreUserManagementViewModel(this._context)
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
  List<EmailRole> listUsersAndInvites({String? resource}) {
    var users = listUsers(resource: resource);
    var userEmails = users.map((user) => user.userEmail).toList();
    var usersAndInvites = List<EmailRole>.from(users);
    usersAndInvites.addAll(listInvites(resource: resource)
        .where((invite) => !userEmails.contains(invite.userEmail)));
    usersAndInvites
        .sort((email1, email2) => email1.userEmail.compareTo(email2.userEmail));
    return usersAndInvites;
  }

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
