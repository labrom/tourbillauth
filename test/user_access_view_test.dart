import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tourbillauth/account_manager.dart';
import 'package:tourbillauth/directory_manager.dart';
import 'package:tourbillauth/libloc.dart';
import 'package:tourbillauth/sign_in_manager.dart';
import 'package:tourbillauth/user_access_view.dart';
import 'package:tourbillauth/user_access_view_model.dart';
import 'package:tourbillon/fake_firestore.dart';
import 'package:tourbillon/firestore.dart';
import 'package:tourbillon/libloc.dart' as tourbillonloc;

void main() {
  testWidgets('view roles, no resource', (tester) async {
    final firestore = FakeFirestoreWrapper();
    await firestore.fake.collection('invites').doc('user1@my.org').set({
      'role': 'guest',
    });
    await firestore.fake.collection('users').doc('user2').set({
      'email': 'user2@my.org',
      'role': 'admin',
    });
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          tourbillonloc.LibLocalizations.delegate,
        ],
        home: Material(
          child: Provider<FirestoreInterface>.value(
            value: firestore,
            builder: (context, _) => UserAccessView(
              viewModel: UserAccessViewModel(context),
            ),
          ),
        ),
      ),
    );
    await tester.idle();
    await tester.pump();
    expect(find.text('user1@my.org'), findsOneWidget);
    expect(find.text('guest'), findsOneWidget);
    expect(find.text('user2@my.org'), findsOneWidget);
    expect(find.text('admin'), findsOneWidget);
  });
  testWidgets('view roles, with a resource', (tester) async {
    final firestore = FakeFirestoreWrapper();
    await firestore.fake.collection('invites').doc('user1@my.org').set({
      'role': 'guest',
    });
    await firestore.fake.collection('users').doc('user2').set({
      'email': 'user2@my.org',
      'role': 'admin',
    });
    await firestore.fake.collection('resources').doc('resource1').set({
      'name': 'Resource 1',
      'roles': {
        'user1@my.org': 'editor',
        'user2': 'viewer',
      },
    });
    final signInManager =
        SignInManager.fakeUser(userId: 'user2', userEmail: 'user2@my.org');
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          tourbillonloc.LibLocalizations.delegate,
          LibLocalizations.delegate,
        ],
        home: Material(
          child: MultiProvider(
            providers: [
              Provider<FirestoreInterface>.value(value: firestore),
              ChangeNotifierProvider(
                create: (context) => AccountManager(context, signInManager),
              ),
              ChangeNotifierProvider(
                create: (context) => DirectoryManager(context, signInManager),
              ),
            ],
            builder: (context, _) => UserAccessView.forResource(
              'resources/resource1',
              viewModel: UserAccessViewModel(context),
            ),
          ),
        ),
      ),
    );
    await tester.idle();
    await tester.pump();
    expect(find.text('user1@my.org'), findsOneWidget);
    expect(find.text('guest'), findsNothing);
    expect(find.text('editor'), findsOneWidget);
    expect(find.text('user2@my.org'), findsOneWidget);
    expect(find.text('admin'), findsNothing);
    expect(find.text('editor'), findsOneWidget);
  });
}
