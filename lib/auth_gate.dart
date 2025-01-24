import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth.dart';

class AuthGate extends ConsumerWidget {
  final Widget child;
  const AuthGate({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      StreamBuilder<User?>(
      stream: ref.watch(authStateChangesProvider) as Stream<User?>,
      builder: (context, snapshot) => snapshot.hasData
          ? child
          : SignInScreen(
              providers: [
                GoogleProvider(
                  // clientId not used on Android and iOS (iOSPreferPlist is true for iOS)
                  clientId: '',
                  iOSPreferPlist: true,
                )
              ],
            ),
    );


}
