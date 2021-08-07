import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tourbillon/log.dart';

/// A service provider for user sign-in.
class SignInManager extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _googleSignInAccount;
  User? _firebaseUser;
  var _signedIn = false;

  SignInManager() {
    Firebase.initializeApp();
  }

  bool get signedIn => _signedIn;

  /// The Google user ID.
  ///
  /// Throws an exception is no user is signed in.
  String get userId => _googleSignInAccount!.id;

  /// The Firebase user ID.
  ///
  /// Throws an exception is no user is signed in.
  String get firebaseUserUid => _firebaseUser!.uid;

  /// The user's email address.
  ///
  /// Throws an exception is no user is signed in.
  String get userEmail => _googleSignInAccount!.email;

  /// A description of the signed-in user.
  ///
  /// Throws an exception is no user is signed in.
  String get userDescription =>
      '${_googleSignInAccount!.displayName} (${_googleSignInAccount!.email})';

  /// A short description of the signed-in user.
  ///
  /// Throws an exception is no user is signed in.
  String get shortUserDescription => _googleSignInAccount!.displayName ?? '';

  /// The signed-in user profile photo URL.
  ///
  /// Throws an exception is no user is signed in.
  String get photoUrl => _googleSignInAccount!.photoUrl ?? '';

  Future<Map<String, String>> get authHeaders async {
    if (!_signedIn || _googleSignInAccount == null) {
      await signIn();
    }
    return _googleSignInAccount!.authHeaders;
  }

  signIn() async {
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? googleSignInAccount) {
      if (googleSignInAccount != null) {
        _onLogin(googleSignInAccount);
      } else {
        _signedIn = false;
        notifyListeners();
      }
    });

    if (_signedIn) {
      try {
        _googleSignIn.signInSilently().whenComplete(() => () {
              notifyListeners();
            });
      } catch (e) {
        log.e('Sign in error: $e');
        _signedIn = false;
        notifyListeners();
      }
    } else {
      _onLogin(await _googleSignIn.signIn());
    }
  }

  void signOut() async {
    await _googleSignIn.signOut().then((_) {
      _googleSignInAccount = null;
      _firebaseUser = null;
      _signedIn = false;
      notifyListeners();
    });
  }

  _onLogin(GoogleSignInAccount? account) async {
    if (account == null) return;
    _googleSignInAccount = account;
    var googleSignInAuthentication = await _googleSignInAccount!.authentication;

    var credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    // Get Firebase user
    var authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);
    _firebaseUser = authResult.user;
    assert(!_firebaseUser!.isAnonymous);

    _signedIn = true;
    notifyListeners();
  }
}
