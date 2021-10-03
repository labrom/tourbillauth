import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tourbillon/firestore.dart';
import 'package:tourbillon/log.dart';

import 'manager_base.dart';
import 'sign_in_manager.dart';

bool isAdmin(BuildContext context) =>
    Provider.of<AccountManager>(context, listen: false).isAdmin;

/// A service provider for account management.
///
/// This service loads current user's role and settings stored in Firestore.
/// It also tells if the current user is an admin. A user is an admin if one
/// of their roles is the admin role. By default, the admin role is `admin`.
///
/// This service expects the following Firestore structure:
/// * a users collection keyed on the user's Firebase UID, default collection
/// name: `users`
/// * documents in the user collection must have a string array field that lists
/// the user's roles, default field name: `roles`
/// * a user settings collection keyed on the user's Firebase UID, default
/// collection name: `user-settings`
/// * documents in the user settings collection contain a map of settings names
/// and values
///
///
///
///
class AccountManager extends ManagerBase {
  final String userCollection;
  final String adminRole;
  final String rolesField;
  final String userSettingCollection;
  final String userInviteResponseCollection;
  final String userInviteResponseEmailField;
  bool _rolesLoaded = false;
  bool _isAdmin = false;

  final Map<String, dynamic> _settings = {};

  AccountManager(
    BuildContext context, {
    this.userCollection = 'users',
    this.adminRole = 'admin',
    this.rolesField = 'roles',
    this.userSettingCollection = 'user-settings',
    this.userInviteResponseCollection = 'user-invite-responses',
    this.userInviteResponseEmailField = 'email',
  }) : super(Provider.of<SignInManager>(context, listen: false));

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
    _settings.clear();
  }

  bool _ensureSignOn() {
    if (!checkSignIn()) {
      _rolesLoaded = false;
      _settings.clear();
      notifyListeners();
      return false;
    }
    return true;
  }

  bool get rolesLoaded => _rolesLoaded;

  bool get isAdmin => _isAdmin;

  Future<void> loadRoles() async {
    if (!_ensureSignOn()) return;
    if (_rolesLoaded) return;

    await _loadRoles();
    _rolesLoaded = true;
    notifyListeners();
  }

  Future<void> _loadRoles() async {
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userId)
        .get()
        .then((snapshot) {
      _isAdmin =
          snapshot.getOrNull<List<String>>(rolesField)?.contains(adminRole) ==
              true;
    }).catchError((error) {
      log.e(error);
      _isAdmin = false;
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
