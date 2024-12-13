import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tourbillon/log.dart';

/// A service provider for user sign-in.
class SignInManager extends ChangeNotifier {
  final GoogleSignIn _googleSignIn;
  GoogleSignInAccount? _googleSignInAccount;
  User? _firebaseUser;
  var _signedIn = false;

  SignInManager() : _googleSignIn = GoogleSignIn() {
    Firebase.initializeApp();
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? googleSignInAccount) {
      if (googleSignInAccount != null) {
        _onGoogleLogin(googleSignInAccount);
      } else {
        _reset();
        notifyListeners();
      }
    });
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _firebaseUser = user;
        _signedIn = true;
      } else {
        _reset();
      }
      notifyListeners();
    });
  }

  factory SignInManager.fakeUser({
    required String userId,
    required String userEmail,
  }) =>
      _FakeSignInManager(userId: userId, userEmail: userEmail);

  bool get signedIn => _signedIn;

  /// The user ID.
  ///
  /// This ID is the one that should be used by clients.
  ///
  /// Throws an exception if no user is signed in.
  String get userId => _firebaseUser!.uid;

  /// The Firebase user ID.
  ///
  /// Throws an exception if no user is signed in.
  String get firebaseUserUid => _firebaseUser!.uid;

  /// The user's email address.
  ///
  /// Throws an exception if no user is signed in.
  String get userEmail => _googleSignInAccount!.email;

  /// A description of the signed-in user.
  ///
  /// Throws an exception if no user is signed in.
  String get userDescription =>
      '${_googleSignInAccount!.displayName} (${_googleSignInAccount!.email})';

  /// A short description of the signed-in user.
  ///
  /// Throws an exception if no user is signed in.
  String get shortUserDescription => _googleSignInAccount!.displayName ?? '';

  /// The signed-in user profile photo URL.
  ///
  /// Throws an exception if no user is signed in.
  String get photoUrl => _googleSignInAccount!.photoUrl ?? '';

  Future<Map<String, String>> get authHeaders async {
    if (!_signedIn || _googleSignInAccount == null) {
      await signIn();
    }
    return _googleSignInAccount!.authHeaders;
  }

  signIn() {
    if (_signedIn && _googleSignInAccount != null) {
      try {
        _googleSignIn.signInSilently().whenComplete(() => () {
              notifyListeners();
            });
      } catch (e) {
        log.e('Sign in error: $e');
        _reset();
        notifyListeners();
      }
    } else {
      _googleSignIn.signIn();
    }
  }

  void signOut() {
    _googleSignIn.signOut();
  }

  void _reset() {
    _googleSignInAccount = null;
    _firebaseUser = null;
    _signedIn = false;
  }

  void _onGoogleLogin(GoogleSignInAccount? account) async {
    if (account == null) {
      _reset();
      return;
    }
    _googleSignInAccount = account;
    final googleAuth = await _googleSignInAccount!.authentication;

    // Get Firebase user
    await FirebaseAuth.instance
        .signInWithCredential(GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    ));
  }
}

class _FakeSignInManager with ChangeNotifier implements SignInManager {
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
  bool _signedIn;

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
