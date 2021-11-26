import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tourbillon/firestore.dart';

import 'account_manager.dart';
import 'app_user.dart';
import 'manager_base.dart';
import 'sign_in_manager.dart';

/// A service provider that gives access to registered users.
///
/// Users are stored in the `users` collection by default (a different name can
/// be specified), where document IDs are the user's UID. Documents contain a
/// mandatory `email` field and an optional `display` fields.
///
/// This widget requires an [AccountManager] to be present in the context.
class DirectoryManager extends ManagerBase {
  final BuildContext _context;
  final List<AppUser> _users = [];
  final String userCollectionName;

  DirectoryManager(
    this._context,
    SignInManager signInManager, {
    this.userCollectionName = 'users',
  }) : super(signInManager) {
    final accountManager = Provider.of<AccountManager>(_context, listen: false);
    accountManager.addListener(() {
      if (accountManager.isAdmin) {
        loadUsers();
      } else {
        clear();
      }
    });
  }

  @override
  void clear() {
    _users.clear();
  }

  void loadUsers() {
    if (!checkSignIn() || !isAdmin(_context)) {
      clear();
      return;
    }
    if (_users.isNotEmpty) return;

    firestoreProvider(_context)
        .instance
        .collection(userCollectionName)
        .snapshots()
        .listen((snapshots) {
      _users.clear();
      for (var snapshot in snapshots.docs) {
        _users.add(AppUser(
          uid: snapshot.id,
          email: snapshot.getOrNull('email'),
          description: snapshot.getOrNull('display'),
        ));
      }
      _users.sort((a, b) =>
          (a.description ?? a.email).compareTo(b.description ?? b.email));
      notifyListeners();
    });
  }

  List<AppUser> findUsers(String query) {
    final searchTerms = query.split(' ');
    if (searchTerms.isEmpty) return [];
    return _users.where((user) => user.matches(searchTerms)).toList();
  }

  AppUser? getUserByEmail(String email) {
    final results = _users.where((user) => user.email == email);
    return results.isEmpty ? null : results.first;
  }

  List<AppUser> get allUsers => _users;
}
