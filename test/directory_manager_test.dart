import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tourbillauth/account_manager.dart';
import 'package:tourbillauth/directory_manager.dart';
import 'package:tourbillauth/sign_in_manager.dart';
import 'package:tourbillon/fake_firestore.dart';
import 'package:tourbillon/firestore.dart';

void main() {
  testWidgets('no users', (tester) async {
    final firestore = FakeFirestoreWrapper();
    final signInManager =
        SignInManager.fakeUser(userId: 'user1', userEmail: 'user1@my.org');
    late DirectoryManager directoryManager;
    await tester.pumpWidget(Provider<FirestoreInterface>.value(
      value: firestore,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AccountManager(context, signInManager),
          ),
          ChangeNotifierProvider(
            create: (context) {
              directoryManager = DirectoryManager(context, signInManager);
              return directoryManager;
            },
            lazy: false,
          ),
        ],
        child: Container(),
      ),
    ));
    signInManager.signIn();
    await tester.pumpAndSettle();
    expect(directoryManager.allUsers, isEmpty);
  });
  testWidgets('some users, but isn\'t admin', (tester) async {
    final firestore = FakeFirestoreWrapper();
    await firestore.fake.collection('users').doc('user1').set({
      'email': 'user1@my.org',
      'roles': ['not-an-admin'],
    });
    final signInManager =
        SignInManager.fakeUser(userId: 'user1', userEmail: 'user1@my.org');
    late DirectoryManager directoryManager;
    await tester.pumpWidget(Provider<FirestoreInterface>.value(
      value: firestore,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AccountManager(context, signInManager),
          ),
          ChangeNotifierProvider(
            create: (context) {
              directoryManager = DirectoryManager(context, signInManager);
              return directoryManager;
            },
            lazy: false,
          ),
        ],
        child: Container(),
      ),
    ));
    signInManager.signIn();
    await tester.pumpAndSettle();
    expect(directoryManager.allUsers, isEmpty);
  });
  testWidgets('is admin, some users', (tester) async {
    final firestore = FakeFirestoreWrapper();
    await firestore.fake.collection('users').doc('user1').set({
      'email': 'user1@my.org',
      'roles': ['admin'],
    });
    final signInManager =
        SignInManager.fakeUser(userId: 'user1', userEmail: 'user1@my.org');
    late DirectoryManager directoryManager;
    await tester.pumpWidget(Provider<FirestoreInterface>.value(
      value: firestore,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AccountManager(context, signInManager),
          ),
          ChangeNotifierProvider(
            create: (context) {
              directoryManager = DirectoryManager(context, signInManager);
              return directoryManager;
            },
            lazy: false,
          ),
        ],
        child: Container(),
      ),
    ));
    signInManager.signIn();
    await tester.pumpAndSettle();
    expect(directoryManager.allUsers.length, equals(1));
    expect(directoryManager.findUsers('user1').length, equals(1));
  });
}
