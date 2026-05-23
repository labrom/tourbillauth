import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// A service provider for the current Firebase Auth session.
///
/// This class is independent of the Firebase sign-in provider. Apps that still
/// use [signIn] must supply [signInHandler] to show their configured sign-in UI.
class SignInManager extends ChangeNotifier {
  final FirebaseAuth? _firebaseAuth;
  final FutureOr<void> Function()? _signInHandler;
  User? _firebaseUser;
  StreamSubscription<User?>? _authStateSubscription;

  SignInManager({
    FirebaseAuth? firebaseAuth,
    FutureOr<void> Function()? signInHandler,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _signInHandler = signInHandler {
    final firebaseAuth = _firebaseAuth!;
    _firebaseUser = firebaseAuth.currentUser;
    _authStateSubscription =
        firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        _firebaseUser = user;
      } else {
        _reset();
      }
      notifyListeners();
    });
  }

  SignInManager._fake()
      : _firebaseAuth = null,
        _signInHandler = null;

  factory SignInManager.fakeUser({
    required String userId,
    required String userEmail,
  }) =>
      _FakeSignInManager(userId: userId, userEmail: userEmail);

  bool get signedIn => _firebaseUser != null;

  /// The Firebase user ID.
  ///
  /// Throws an exception if no user is signed in.
  String get userId => _firebaseUser!.uid;

  /// The Firebase user ID.
  ///
  /// Throws an exception if no user is signed in.
  String get firebaseUserUid => userId;

  /// The user's email address.
  ///
  /// Throws an exception if no user is signed in.
  String get userEmail => _firebaseUser!.email ?? '';

  /// A description of the signed-in user.
  ///
  /// Throws an exception if no user is signed in.
  String get userDescription => _firebaseUser!.displayName == null
      ? userEmail
      : '${_firebaseUser!.displayName} ($userEmail)';

  /// A short description of the signed-in user.
  ///
  /// Throws an exception if no user is signed in.
  String get shortUserDescription => _firebaseUser!.displayName ?? userEmail;

  /// The signed-in user profile photo URL.
  ///
  /// Throws an exception if no user is signed in.
  String get photoUrl => _firebaseUser!.photoURL ?? '';

  Future<Map<String, String>> get authHeaders async {
    final token = await _firebaseUser!.getIdToken();
    return {'Authorization': 'Bearer $token'};
  }

  Future<void> signIn() async {
    final signInHandler = _signInHandler;
    if (signInHandler == null) {
      throw UnsupportedError(
        'SignInManager requires a signInHandler to start sign-in.',
      );
    }
    await signInHandler();
  }

  Future<void> signOut() => _firebaseAuth!.signOut();

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }

  void _reset() {
    _firebaseUser = null;
  }
}

class _FakeSignInManager extends SignInManager {
  bool _signedIn;

  @override
  final String userId;

  @override
  final String userEmail;

  final Map<String, String> _authHeaders;

  _FakeSignInManager({
    required this.userId,
    required this.userEmail,
    Map<String, String> authHeaders = const {},
  })  : _authHeaders = authHeaders,
        _signedIn = false,
        super._fake();

  @override
  Future<Map<String, String>> get authHeaders =>
      Future.sync(() => _authHeaders);

  @override
  String get firebaseUserUid => userId;

  @override
  String get photoUrl => '';

  @override
  String get shortUserDescription => userEmail;

  @override
  Future<void> signIn() async {
    _signedIn = true;
    notifyListeners();
  }

  @override
  Future<void> signOut() async {
    _signedIn = false;
    notifyListeners();
  }

  @override
  bool get signedIn => _signedIn;

  @override
  String get userDescription => userEmail;

  @override
  void _reset() {
    _signedIn = false;
  }
}
