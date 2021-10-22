import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tourbillon/firestore.dart';

import 'account_manager.dart';
import 'app_user.dart';
import 'manager_base.dart';
import 'sign_in_manager.dart';

/// A service provider that gives access to registered users.
class DirectoryManager extends ManagerBase {
  final BuildContext _context;
  final List<AppUser> _users = [];

  DirectoryManager(
    this._context,
    SignInManager signInManager,
  ) : super(signInManager) {
    var accountManager = Provider.of<AccountManager>(_context, listen: false);
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

    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((snapshots) {
      _users.clear();
      for (var snapshot in snapshots.docs) {
        _users.add(AppUser(
          uid: snapshot.id,
          email: snapshot.getOrNull('email'),
          description: snapshot.getOrNull('description'),
        ));
      }
      _users.sort((a, b) =>
          (a.description ?? a.email).compareTo(b.description ?? b.email));
      notifyListeners();
    });
  }

  List<AppUser> findUsers(String query) {
    var searchTerms = query.split(' ');
    if (searchTerms.isEmpty) return [];
    return _users.where((user) => user.matches(searchTerms)).toList();
  }

  AppUser? getUserByEmail(String email) {
    var results = _users.where((user) => user.email == email);
    return results.isEmpty ? null : results.first;
  }

  List<AppUser> get allUsers => _users;
}
