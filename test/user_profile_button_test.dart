import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tourbillauth/auth.dart';
import 'package:tourbillauth/user_profile_button.dart';

void main() {
  testWidgets('shows a generic profile icon when there is no user',
      (tester) async {
    await tester.pumpWidget(_appWithUser(null));

    expect(find.byIcon(Icons.person_rounded), findsOneWidget);
  });

  testWidgets('prefers the display name for the fallback initial',
      (tester) async {
    await tester.pumpWidget(
      _appWithUser(
        _FakeUser(displayName: '  alice ', email: 'bob@example.com'),
      ),
    );

    expect(find.text('A'), findsOneWidget);
  });

  testWidgets('uses the email when the display name is empty', (tester) async {
    await tester.pumpWidget(
      _appWithUser(_FakeUser(displayName: ' ', email: 'bob@example.com')),
    );

    expect(find.text('B'), findsOneWidget);
  });

  testWidgets('invokes the supplied callback', (tester) async {
    var pressed = false;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [userProvider.overrideWithValue(null)],
        child: MaterialApp(
          home: Scaffold(
            body: UserProfileButton(
              tooltip: 'Profile and settings',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(UserProfileButton));

    expect(pressed, isTrue);
  });
}

Widget _appWithUser(User? user) => ProviderScope(
      overrides: [userProvider.overrideWithValue(user)],
      child: const MaterialApp(
        home: Scaffold(
          body: UserProfileButton(onPressed: _doNothing),
        ),
      ),
    );

void _doNothing() {}

class _FakeUser extends Fake implements User {
  _FakeUser({this.displayName, this.email});

  @override
  final String? displayName;

  @override
  final String? email;

  @override
  String? get photoURL => null;
}
