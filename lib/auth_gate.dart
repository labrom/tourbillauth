import 'auth.dart';
import 'config.dart';
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({
    super.key,
    required this.child,
    this.authProviders,
    this.enableEmailPasswordAuth = false,
  });

  final Widget child;
  final List<AuthProvider>? authProviders;
  final bool enableEmailPasswordAuth;

  @override
  Widget build(BuildContext context, WidgetRef ref) => StreamBuilder<User?>(
        stream: ref.watch(authStateChangesStreamProvider),
        builder: (context, snapshot) => snapshot.hasData
            ? child
            : SignInScreen(
                providers: authProviders ??
                    defaultAuthProviders(
                      enableEmailPasswordAuth: enableEmailPasswordAuth,
                    ),
              ),
      );
}
