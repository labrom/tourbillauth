import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tourbillauth/user_access_view_model.dart';
import 'package:tourbillon/fake_firestore.dart';
import 'package:tourbillon/firestore.dart';

void main() {
  group('list users invites', () {
    testWidgets('with roles, without resource', (tester) async {
      var firestore = FakeFirestoreWrapper();
      await firestore.fake.collection('users').doc('user2').set({
        'email': 'user2@my.org',
        'role': 'guest',
      });
      await firestore.fake.collection('users').doc('user1').set({
        'email': 'user1@my.org',
        'role': 'admin',
      });
      await firestore.fake.collection('invites').doc('user2@my.org').set({
        'role': 'guest',
      });
      await firestore.fake.collection('invites').doc('user1@my.org').set({
        'role': 'admin',
      });
      late UserAccessViewModel viewModel;
      await tester.pumpWidget(Provider<FirestoreInterface>.value(
        value: firestore,
        child: ChangeNotifierProvider(
          create: (context) {
            viewModel = UserAccessViewModel(context);
            return viewModel;
          },
          lazy: false,
          child: Container(),
        ),
      ));
      var users = viewModel.listUsers();
      var invites = viewModel.listInvites();
      expect(users.length, equals(2));
      expect(invites.length, equals(2));
      expect(users[0].userEmail, equals('user1@my.org'));
      expect(users[0].role, equals('admin'));
      expect(invites[1].userEmail, equals('user2@my.org'));
      expect(invites[1].role, equals('guest'));
    });
    testWidgets('users & invites, without roles, without resource',
        (tester) async {
      var firestore = FakeFirestoreWrapper();
      await firestore.fake.collection('users').doc('user4').set({
        'email': 'user4@my.org',
      });
      await firestore.fake.collection('users').doc('user2').set({
        'email': 'user2@my.org',
      });
      await firestore.fake.collection('invites').doc('user2@my.org').set({});
      await firestore.fake.collection('invites').doc('user3@my.org').set({});
      late UserAccessViewModel viewModel;
      await tester.pumpWidget(Provider<FirestoreInterface>.value(
        value: firestore,
        child: ChangeNotifierProvider(
          create: (context) {
            viewModel = UserAccessViewModel(context);
            return viewModel;
          },
          lazy: false,
          child: Container(),
        ),
      ));
      var usersInvites = viewModel.listUsersAndInvites();
      expect(usersInvites.length, equals(3));
      expect(usersInvites[0].userEmail, equals('user2@my.org'));
      expect(usersInvites[1].userEmail, equals('user3@my.org'));
      expect(usersInvites[2].userEmail, equals('user4@my.org'));
    });
    testWidgets('with roles, with resource', (tester) async {
      var firestore = FakeFirestoreWrapper();
      await firestore.fake.collection('users').doc('user1').set({
        'email': 'user1@my.org',
        'role': 'admin',
      });
      await firestore.fake.collection('invites').doc('user2@my.org').set({
        'role': 'guest',
      });
      await firestore.fake.collection('resources').doc('resource1').set({
        'roles': {
          'user1': 'editor',
          'user2@my.org': 'reader',
        },
      });
      late UserAccessViewModel viewModel;
      await tester.pumpWidget(Provider<FirestoreInterface>.value(
        value: firestore,
        child: ChangeNotifierProvider(
          create: (context) {
            viewModel = UserAccessViewModel(context);
            return viewModel;
          },
          lazy: false,
          child: Container(),
        ),
      ));
      viewModel.listUsers(resource: 'resources/resource1');
      viewModel.listInvites(resource: 'resources/resource1');
      await tester.pump();
      var users = viewModel.listUsers(resource: 'resources/resource1');
      var invites = viewModel.listInvites(resource: 'resources/resource1');
      expect(users.length, equals(1));
      expect(invites.length, equals(1));
      expect(users.first.userEmail, equals('user1@my.org'));
      expect(users.first.role, equals('editor'));
      expect(invites.first.userEmail, equals('user2@my.org'));
      expect(invites.first.role, equals('reader'));
    });
  });
  testWidgets('add users/invites', (tester) async {
    var fakeFirestoreWrapper = FakeFirestoreWrapper();
    late UserAccessViewModel viewModel;
    await tester.pumpWidget(Provider<FirestoreInterface>.value(
      value: fakeFirestoreWrapper,
      child: ChangeNotifierProvider(
        create: (context) {
          viewModel = UserAccessViewModel(context);
          return viewModel;
        },
        lazy: false,
        child: Container(),
      ),
    ));
    viewModel.addUser('user1', email: 'user1@my.org', role: 'admin');
    viewModel.addUser('user2', email: 'user2@my.org', role: 'guest');
    viewModel.addInvite('user1@my.org', role: 'admin');
    viewModel.addInvite('user2@my.org', role: 'guest');
    await fakeFirestoreWrapper.fake.flush();
    await tester.pump();
    var users = viewModel.listUsers();
    var invites = viewModel.listInvites();
    expect(users.length, equals(2));
    expect(viewModel.listInvites().length, equals(2));
    expect(users[0].userEmail, equals('user1@my.org'));
    expect(users[0].role, equals('admin'));
    expect(invites[1].userEmail, equals('user2@my.org'));
    expect(invites[1].role, equals('guest'));
  });
  testWidgets('remove users/invites', (tester) async {
    var fakeFirestoreWrapper = FakeFirestoreWrapper();
    await fakeFirestoreWrapper.fake.collection('users').doc('user1').set({
      'email': 'user1@my.org',
      'role': 'admin',
    });
    await fakeFirestoreWrapper.fake.collection('users').doc('user2').set({
      'email': 'user2@my.org',
      'role': 'guest',
    });
    await fakeFirestoreWrapper.fake
        .collection('invites')
        .doc('user1@my.org')
        .set({
      'role': 'admin',
    });
    await fakeFirestoreWrapper.fake
        .collection('invites')
        .doc('user2@my.org')
        .set({
      'role': 'guest',
    });
    late UserAccessViewModel viewModel;
    await tester.pumpWidget(Provider<FirestoreInterface>.value(
      value: fakeFirestoreWrapper,
      child: ChangeNotifierProvider(
        create: (context) {
          viewModel = UserAccessViewModel(context);
          return viewModel;
        },
        lazy: false,
        child: Container(),
      ),
    ));
    viewModel.removeUser('user2');
    viewModel.removeInvite('user1@my.org');
    await fakeFirestoreWrapper.fake.flush();
    var users = viewModel.listUsers();
    var invites = viewModel.listInvites();
    expect(users.length, equals(1));
    expect(invites.length, equals(1));
    expect(users[0].userEmail, equals('user1@my.org'));
    expect(users[0].role, equals('admin'));
    expect(invites[0].userEmail, equals('user2@my.org'));
    expect(invites[0].role, equals('guest'));
  });
}
