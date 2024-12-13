import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// A service provider for user sign-in.
class SignInManager extends ChangeNotifier {
  final GoogleSignIn _googleSignIn;
  GoogleSignInAccount? _googleSignInAccount;
  User? _firebaseUser;

  SignInManager() : _googleSignIn = GoogleSignIn() {
    Firebase.initializeApp();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _firebaseUser = user;
      } else {
        _reset();
      }
      notifyListeners();
    });

    // Record Google sign in for direct access to auth headers
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? googleSignInAccount) {
          _googleSignInAccount = googleSignInAccount;
    });
  }

  factory SignInManager.fakeUser({
    required String userId,
    required String userEmail,
  }) =>
      _FakeSignInManager(userId: userId, userEmail: userEmail);

  bool get signedIn => _firebaseUser != null;

  /// The user ID for the underlying auth provider (Google).
  ///
  /// Throws an exception if no user is signed in.
  String get userId => _googleSignInAccount!.id;

  /// The Firebase user ID.
  ///
  /// Throws an exception if no user is signed in.
  String get firebaseUserUid => _firebaseUser!.uid;

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
  String get shortUserDescription => _firebaseUser!.displayName ?? '';

  /// The signed-in user profile photo URL.
  ///
  /// Throws an exception if no user is signed in.
  String get photoUrl => _firebaseUser!.photoURL ?? '';

  Future<Map<String, String>> get authHeaders async {
    if (_googleSignInAccount == null) {
      await FirebaseAuth.instance.signInWithProvider(GoogleAuthProvider());
    }
    return _googleSignInAccount!.authHeaders;
  }

  void signIn() {
    FirebaseAuth.instance.signInWithProvider(GoogleAuthProvider());
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void _reset() {
    _googleSignInAccount = null;
    _firebaseUser = null;
  }
}

class _FakeSignInManager with ChangeNotifier implements SignInManager {
  bool _signedIn;

  @override
  final String userId;

  @override
  final String userEmail;

  _FakeSignInManager({
    required this.userId,
    required this.userEmail,
  }) : _signedIn = true;

  @override
  Future<Map<String, String>> get authHeaders => Future.sync(() => {});

  @override
  String get firebaseUserUid => throw UnimplementedError();

  @override
  String get photoUrl => '';

  @override
  String get shortUserDescription => userEmail;

  @override
  signIn() {
    _signedIn = true;
    notifyListeners();
  }

  @override
  void signOut() {
    _signedIn = false;
    notifyListeners();
  }

  @override
  bool get signedIn => _signedIn;

  @override
  String get userDescription => userEmail;

  @override
  User? _firebaseUser;

  @override
  GoogleSignInAccount? _googleSignInAccount;

  @override
  GoogleSignIn get _googleSignIn => throw UnimplementedError();

  @override
  void _onGoogleLogin(GoogleSignInAccount? account) {
    throw UnimplementedError();
  }

  @override
  void _reset() {
    throw UnimplementedError();
  }
}
