import 'package:flutter/foundation.dart';

import 'sign_in_manager.dart';

abstract class ManagerBase extends ChangeNotifier {
  final SignInManager signInManager;
  String? _userId;

  ManagerBase(this.signInManager) {
    signInManager.addListener(_onSignInManagerNotify);
  }

  void _onSignInManagerNotify() {
    checkSignIn();
    onSignInManagerNotify(signInManager.signedIn);
  }

  /// Invoked when [SignInManager] notifies its listeners.
  ///
  /// This class ensures that there's a signed-user whenever [SignInManager]
  /// notifies, but also allows child classes to optionally add their own handling
  /// of these notifications if they need to.
  /// This method does nothing, and it is invoked after this class checked sign in
  /// and potentially invoked [clear()].
  void onSignInManagerNotify(bool signedIn) {}

  /// Clears internal data when no user is signed in, or the signed-in user has changed.
  void clear();

  String? get userId => _userId;

  String? get userEmail =>
      signInManager.signedIn ? signInManager.userEmail : null;

  /// Checks if there is a signed-in user.
  ///
  /// If no user is currently signed in, invokes [clear()] and returns false.
  /// In the case where there is a signed-in user, but it is a different
  /// user than previously, [clear()] is also invoked, but the method returns true.
  bool checkSignIn() {
    if (_userId != null &&
        (!signInManager.signedIn || signInManager.userId != _userId)) {
      clear();
      _userId = signInManager.signedIn ? signInManager.userId : null;
      return signInManager.signedIn;
    }
    if (_userId == null && signInManager.signedIn) {
      _userId = signInManager.userId;
    }
    return signInManager.signedIn;
  }
}
