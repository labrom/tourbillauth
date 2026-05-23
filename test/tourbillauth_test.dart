import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tourbillauth/config.dart';

void main() {
  group('defaultAuthProviders', () {
    test('uses Google auth by default', () {
      final providers = defaultAuthProviders();

      expect(providers, hasLength(1));
      expect(providers.single, isA<GoogleProvider>());
    });

    test('includes email/password auth when enabled', () {
      final providers = defaultAuthProviders(enableEmailPasswordAuth: true);

      expect(providers, hasLength(2));
      expect(providers[0], isA<EmailAuthProvider>());
      expect(providers[1], isA<GoogleProvider>());
    });
  });
}
