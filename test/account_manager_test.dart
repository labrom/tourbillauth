import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tourbillauth/account_manager.dart';
import 'package:tourbillauth/sign_in_manager.dart';
import 'package:tourbillon/fake_firestore.dart';
import 'package:tourbillon/firestore.dart';

void main() {
  testWidgets('no roles', (tester) async {
    final firestore = FakeFirestoreWrapper();
    final signInManager =
        SignInManager.fakeUser(userId: 'user1', userEmail: 'user1@my.org');
    late AccountManager accountManager;
    await tester.pumpWidget(Provider<FirestoreInterface>.value(
      value: firestore,
      child: ChangeNotifierProvider(
        create: (context) {
          accountManager = AccountManager(context, signInManager);
          return accountManager;
        },
        lazy: false,
        child: Container(),
      ),
    ));
    accountManager.loadRoles();
    await tester.pumpAndSettle();
    expect(accountManager.userId, equals('user1'));
    expect(accountManager.userEmail, equals('user1@my.org'));
    expect(accountManager.roles, isEmpty);
    expect(accountManager.isAdmin, isFalse);
  });
  testWidgets('no admin role', (tester) async {
    final firestore = FakeFirestoreWrapper();
    await firestore.fake.collection('users').doc('user1').set({
      'email': 'user1@my.org',
      'roles': ['clown', 'CEO'],
    });
    final signInManager =
        SignInManager.fakeUser(userId: 'user1', userEmail: 'user1@my.org');
    late AccountManager accountManager;
    await tester.pumpWidget(Provider<FirestoreInterface>.value(
      value: firestore,
      child: ChangeNotifierProvider(
        create: (context) {
          accountManager = AccountManager(context, signInManager);
          return accountManager;
        },
        lazy: false,
        child: Container(),
      ),
    ));
    accountManager.loadRoles();
    await tester.pumpAndSettle();
    expect(accountManager.userId, equals('user1'));
    expect(accountManager.userEmail, equals('user1@my.org'));
    expect(accountManager.roles.length, equals(2));
    expect(accountManager.isAdmin, isFalse);
  });
  testWidgets('admin role', (tester) async {
    final firestore = FakeFirestoreWrapper();
    await firestore.fake.collection('users').doc('user1').set({
      'email': 'user1@my.org',
      'roles': ['admin'],
    });
    final signInManager =
        SignInManager.fakeUser(userId: 'user1', userEmail: 'user1@my.org');
    late AccountManager accountManager;
    await tester.pumpWidget(Provider<FirestoreInterface>.value(
      value: firestore,
      child: ChangeNotifierProvider(
        create: (context) {
          accountManager = AccountManager(context, signInManager);
          return accountManager;
        },
        lazy: false,
        child: Container(),
      ),
    ));
    accountManager.loadRoles();
    await tester.pumpAndSettle();
    expect(accountManager.userId, equals('user1'));
    expect(accountManager.userEmail, equals('user1@my.org'));
    expect(accountManager.roles, equals(['admin']));
    expect(accountManager.isAdmin, isTrue);
  });
  testWidgets('sign out', (tester) async {
    final firestore = FakeFirestoreWrapper();
    await firestore.fake.collection('users').doc('user1').set({
      'email': 'user1@my.org',
      'roles': ['admin'],
    });
    final signInManager =
        SignInManager.fakeUser(userId: 'user1', userEmail: 'user1@my.org');
    late AccountManager accountManager;
    await tester.pumpWidget(Provider<FirestoreInterface>.value(
      value: firestore,
      child: ChangeNotifierProvider(
        create: (context) {
          accountManager = AccountManager(context, signInManager);
          return accountManager;
        },
        lazy: false,
        child: Container(),
      ),
    ));
    accountManager.loadRoles();
    await tester.pumpAndSettle();
    signInManager.signOut();
    expect(accountManager.userId, isNull);
    expect(accountManager.userEmail, isNull);
    expect(accountManager.roles, isEmpty);
    expect(accountManager.isAdmin, isFalse);
  });
}
