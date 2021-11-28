import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tourbillon/firestore.dart';
import 'package:tourbillon/log.dart';

import 'manager_base.dart';
import 'sign_in_manager.dart';

/// Tells whether or not the current user has the admin role.
///
/// This function requires an [AccountManager] to be present in the context.
///
/// Admin role's default name is `admin` but a different name can be specified
/// in the [AccountManager] constructor.
bool isAdmin(BuildContext context) => context.read<AccountManager>().isAdmin;

/// A service provider for account management.
///
/// This service loads current user's role and settings stored in Firestore.
/// It also tells if the current user is an admin. A user is an admin if one
/// of their roles is the admin role. By default, the admin role is `admin`.
///
/// This service also handles registering the current Firebase user if they
/// don't have a user entry in the application yet, and there is an invitation
/// with a matching email address.
///
/// This service expects the following Firestore structure:
/// * a users collection keyed on the user's Firebase UID, default collection
/// name: `users`
/// * an invitations collection in which documents contain an `email` field,
/// default collection name: `invites`
/// * documents in the user and invite collections must have a string array
/// field that lists the user's roles, default field name: `roles`
/// * a user settings collection keyed on the user's Firebase UID, default
/// collection name: `user-settings`
/// * documents in the user settings collection contain a map of settings names
/// and values
class AccountManager extends ManagerBase {
  final BuildContext _context;
  final String userCollectionName;
  final String adminRole;
  final String rolesFieldName;
  final String userSettingCollectionName;
  final String inviteCollectionName;
  bool _rolesLoaded = false;
  bool _isAdmin = false;
  final List<String> _roles = [];

  final Map<String, dynamic> _settings = {};

  AccountManager(
    this._context,
    SignInManager signInManager, {
    this.userCollectionName = 'users',
    this.adminRole = 'admin',
    this.rolesFieldName = 'roles',
    this.userSettingCollectionName = 'user-settings',
    this.inviteCollectionName = 'invites',
  }) : super(signInManager);

  @override
  void onSignInManagerNotify(bool signedIn) {
    if (signedIn) {
      loadRoles();
      _loadSettings();
    } else {
      clear();
      notifyListeners();
    }
  }

  @override
  void clear() {
    _isAdmin = false;
    _rolesLoaded = false;
    _roles.clear();
    _settings.clear();
    log.i('Cleared roles');
  }

  bool get rolesLoaded => _rolesLoaded;

  bool get isAdmin => _isAdmin;

  void loadRoles() {
    if (!checkSignIn()) return;
    if (_rolesLoaded) return;

    final previousRoles = List.of(_roles);
    try {
      firestoreProvider(_context)
          .instance
          .collection(userCollectionName)
          .doc(userId)
          .snapshots()
          .listenUnique((snapshot) {
        _rolesLoaded = snapshot.exists;
        if (snapshot.exists) {
          _roles.clear();
          _roles.addAll(snapshot.getListOf<String>(rolesFieldName));
          _roles.sort((role1, role2) => role1.compareTo(role2));
          _isAdmin = _roles.contains(adminRole);
          if (!listEquals(_roles, previousRoles)) {
            notifyListeners();
            log.i('Loaded roles');
          }
        } else {
          clear();
          notifyListeners();
        }
      }, key: '$userCollectionName/$userId');
    } catch (error) {
      log.e(error);
      clear();
    }
  }

  List<String> get roles => List.of(_roles, growable: false);

  void convertInvite() {
    if (!checkSignIn()) return;
    if (_rolesLoaded) {
      log.i('User $userId already exists');
      // Delete invite doc (although this could be done by a Firebase function)
      firestoreProvider(_context)
          .instance
          .collection(inviteCollectionName)
          .where('email', isEqualTo: userEmail)
          .get()
          .then((snapshot) {
        // Should return one document at most
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
      return;
    }
    firestoreProvider(_context)
        .instance
        .collection(inviteCollectionName)
        .where('email', isEqualTo: userEmail)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        // Assume there's only one invite
        final inviteDoc = snapshot.docs.first;
        firestoreProvider(_context)
            .instance
            .collection(userCollectionName)
            .doc(userId!)
            .set({
          'email': userEmail,
          rolesFieldName: inviteDoc.getListOf(rolesFieldName),
          'last-updated': DateTime.now(),
        });
        loadRoles();
      } else {
        log.i('No invite found for $userEmail');
      }
    });
  }

  Future<void> _loadSettings() async {
    _settings.clear();
    await firestoreProvider(_context)
        .instance
        .collection(userSettingCollectionName)
        .doc(userId)
        .get()
        .then((snapshot) {
      _settings.addAll(snapshot.data() ?? {});
      notifyListeners();
    });
  }

  T? setting<T>(String key) => _settings[key];

  Future<void> writeSetting<T>(String key, T value) {
    _settings[key] = value;
    return firestoreProvider(_context)
        .instance
        .collection(userSettingCollectionName)
        .doc(userId)
        .set({key: value}, SetOptions(merge: true)).then((_) {
      notifyListeners();
    });
  }
}
