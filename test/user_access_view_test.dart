import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tourbillauth/account_repository.dart';
import 'package:tourbillauth/user_directory.dart';
import 'package:tourbillauth/libloc.dart';
import 'package:tourbillauth/sign_in_manager.dart';
import 'package:tourbillauth/user_access_view.dart';
import 'package:tourbillauth/user_access_view_model.dart';
import 'package:tourbillon/fake_firestore.dart';
import 'package:tourbillon/firestore.dart';
import 'package:tourbillon/libloc.dart' as tourbillonloc;

import 'user_access_view_test.mocks.dart';

@GenerateMocks([UserAccessViewModel])
void main() {
  group('view users', () {
    testWidgets('view roles, no resource', (tester) async {
      final firestore = FakeFirestoreWrapper();
      await firestore.fake.collection('invites').doc('invite1').set({
        'email': 'user1@my.org',
        'roles': ['guest'],
      });
      await firestore.fake.collection('users').doc('user2').set({
        'email': 'user2@my.org',
        'roles': ['admin'],
      });
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [
            tourbillonloc.LibLocalizations.delegate,
            LibLocalizations.delegate,
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
    testWidgets('view multiple roles, no resource', (tester) async {
      final firestore = FakeFirestoreWrapper();
      await firestore.fake.collection('invites').doc('invite1').set({
        'email': 'user1@my.org',
        'roles': ['reader', 'guest'],
      });
      await firestore.fake.collection('users').doc('user2').set({
        'email': 'user2@my.org',
        'roles': ['chief', 'admin'],
      });
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [
            tourbillonloc.LibLocalizations.delegate,
            LibLocalizations.delegate,
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
      expect(find.text('guest, reader'), findsOneWidget);
      expect(find.text('user2@my.org'), findsOneWidget);
      expect(find.text('admin, chief'), findsOneWidget);
    });
    testWidgets('view roles, with a resource', (tester) async {
      final firestore = FakeFirestoreWrapper();
      await firestore.fake.collection('invites').doc('invite1').set({
        'email': 'user1@my.org',
        'roles': ['guest'],
      });
      await firestore.fake.collection('users').doc('user2').set({
        'email': 'user2@my.org',
        'roles': ['admin'],
      });
      await firestore.fake.collection('resources').doc('resource1').set({
        'name': 'Resource 1',
        'roles:invite1': ['editor'],
        'roles:user2': ['viewer'],
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
                  create: (context) =>
                      AccountRepository(context, signInManager),
                ),
                ChangeNotifierProvider(
                  create: (context) => UserDirectory(context, signInManager),
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
      expect(find.text('viewer'), findsOneWidget);
    });
  });
  group('add users', () {
    testWidgets('add user, no resource', (tester) async {
      final viewModel = MockUserAccessViewModel();
      when(viewModel.listUsersAndInvites()).thenReturn([]);
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [
            tourbillonloc.LibLocalizations.delegate,
            LibLocalizations.delegate,
          ],
          home: Material(
            child: UserAccessView(
              viewModel: viewModel,
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextField), 'user1@my.org');
      await tester.pump();
      await tester.tap(find.text('ADD'));
      verify(viewModel.addInvite('user1@my.org', roles: []));
    });
  });
}
