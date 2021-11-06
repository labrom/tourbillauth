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
        'roles': ['guest'],
      });
      await firestore.fake.collection('users').doc('user1').set({
        'email': 'user1@my.org',
        'roles': ['admin'],
      });
      await firestore.fake.collection('invites').doc('invite1').set({
        'email': 'user1@my.org',
        'roles': ['admin'],
      });
      await firestore.fake.collection('invites').doc('invite2').set({
        'email': 'user2@my.org',
        'roles': ['guest'],
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
      expect(users[0].roles.first, equals('admin'));
      expect(users[1].userEmail, equals('user2@my.org'));
      expect(users[1].roles.first, equals('guest'));
      expect(invites[0].userEmail, equals('user1@my.org'));
      expect(invites[0].roles.first, equals('admin'));
      expect(invites[1].userEmail, equals('user2@my.org'));
      expect(invites[1].roles.first, equals('guest'));
    });
    testWidgets('combined list with roles, without resource', (tester) async {
      var firestore = FakeFirestoreWrapper();
      await firestore.fake.collection('users').doc('user2').set({
        'email': 'user2@my.org',
        'roles': ['guest'],
      });
      await firestore.fake.collection('users').doc('user1').set({
        'email': 'user1@my.org',
        'roles': ['admin'],
      });
      await firestore.fake.collection('invites').doc('invite1').set({
        'email': 'user1@my.org',
        'roles': ['admin'],
      });
      await firestore.fake.collection('invites').doc('invite2').set({
        'email': 'user2@my.org',
        'roles': ['guest'],
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
      var usersAndInvites = viewModel.listUsersAndInvites();
      expect(usersAndInvites.length, equals(2));
      expect(usersAndInvites[0].userEmail, equals('user1@my.org'));
      expect(usersAndInvites[0].roles.length, equals(1));
      expect(usersAndInvites[1].userEmail, equals('user2@my.org'));
      expect(usersAndInvites[1].roles.length, equals(1));
    });
    testWidgets('with multiple roles, without resource', (tester) async {
      var firestore = FakeFirestoreWrapper();
      await firestore.fake.collection('users').doc('user2').set({
        'email': 'user2@my.org',
        'roles': ['tourist', 'guest'],
      });
      await firestore.fake.collection('users').doc('user1').set({
        'email': 'user1@my.org',
        'roles': ['boss', 'admin'],
      });
      await firestore.fake.collection('invites').doc('invite1').set({
        'email': 'user1@my.org',
        'roles': ['nimda', 'admin'],
      });
      await firestore.fake.collection('invites').doc('invite2').set({
        'email': 'user2@my.org',
        'roles': ['tseug', 'guest'],
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
      expect(users.length, equals(2));
      expect(invites.length, equals(2));
      expect(users[0].userEmail, equals('user1@my.org'));
      expect(users[0].roles.length, equals(2));
      expect(users[0].roles.toList()[0], equals('admin'));
      expect(users[0].roles.toList()[1], equals('boss'));
      expect(users[1].userEmail, equals('user2@my.org'));
      expect(users[1].roles.length, equals(2));
      expect(users[1].roles.toList()[0], equals('guest'));
      expect(users[1].roles.toList()[1], equals('tourist'));
      expect(invites[0].userEmail, equals('user1@my.org'));
      expect(invites[0].roles.length, equals(2));
      expect(invites[0].roles.toList()[0], equals('admin'));
      expect(invites[0].roles.toList()[1], equals('nimda'));
      expect(invites[1].userEmail, equals('user2@my.org'));
      expect(invites[1].roles.length, equals(2));
      expect(invites[1].roles.toList()[0], equals('guest'));
      expect(invites[1].roles.toList()[1], equals('tseug'));
    });
    testWidgets('combined list with multiple roles, without resource',
        (tester) async {
      var firestore = FakeFirestoreWrapper();
      await firestore.fake.collection('users').doc('user2').set({
        'email': 'user2@my.org',
        'roles': ['guest', 'tourist'],
      });
      await firestore.fake.collection('users').doc('user1').set({
        'email': 'user1@my.org',
        'roles': ['admin', 'boss'],
      });
      await firestore.fake.collection('invites').doc('invite1').set({
        'email': 'user1@my.org',
        'roles': ['admin', 'nimda'],
      });
      await firestore.fake.collection('invites').doc('invite2').set({
        'email': 'user2@my.org',
        'roles': ['guest', 'tseug'],
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
      var usersAndInvites = viewModel.listUsersAndInvites();
      expect(usersAndInvites.length, equals(2));
      expect(usersAndInvites[0].userEmail, equals('user1@my.org'));
      expect(usersAndInvites[0].roles.length, equals(3));
      expect(usersAndInvites[0].roles.toList()[0], equals('admin'));
      expect(usersAndInvites[0].roles.toList()[1], equals('boss'));
      expect(usersAndInvites[0].roles.toList()[2], equals('nimda'));
      expect(usersAndInvites[1].userEmail, equals('user2@my.org'));
      expect(usersAndInvites[1].roles.length, equals(3));
      expect(usersAndInvites[1].roles.toList()[0], equals('guest'));
      expect(usersAndInvites[1].roles.toList()[1], equals('tourist'));
      expect(usersAndInvites[1].roles.toList()[2], equals('tseug'));
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
      await firestore.fake.collection('invites').doc('invite2').set({
        'email': 'user2@my.org',
      });
      await firestore.fake.collection('invites').doc('invite3').set({
        'email': 'user3@my.org',
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
        'roles': ['admin'],
      });
      await firestore.fake.collection('invites').doc('invite2').set({
        'email': 'user2@my.org',
        'roles': ['guest'],
      });
      await firestore.fake.collection('resources').doc('resource1').set({
        'roles:user1': ['editor'],
        'roles:invite2': ['reader'],
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
      expect(users.first.roles.length, equals(1));
      expect(users.first.roles.first, equals('editor'));
      expect(invites.first.userEmail, equals('user2@my.org'));
      expect(invites.first.roles.length, equals(1));
      expect(invites.first.roles.first, equals('reader'));
    });
    testWidgets('with multiple roles, with resource', (tester) async {
      var firestore = FakeFirestoreWrapper();
      await firestore.fake.collection('users').doc('user1').set({
        'email': 'user1@my.org',
        'roles': ['admin'],
      });
      await firestore.fake.collection('invites').doc('invite2').set({
        'email': 'user2@my.org',
        'roles': ['guest'],
      });
      await firestore.fake.collection('resources').doc('resource1').set({
        'roles:user1': ['editor', 'author'],
        'roles:invite2': ['reader', 'lecturer'],
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
      expect(users.first.roles.length, equals(2));
      expect(users.first.roles.toList()[0], equals('author'));
      expect(users.first.roles.toList()[1], equals('editor'));
      expect(invites.first.userEmail, equals('user2@my.org'));
      expect(invites.first.roles.length, equals(2));
      expect(invites.first.roles.toList()[0], equals('lecturer'));
      expect(invites.first.roles.toList()[1], equals('reader'));
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
    viewModel.addUser('user1', email: 'user1@my.org', roles: ['admin']);
    viewModel.addUser('user2', email: 'user2@my.org', roles: ['guest']);
    viewModel.addInvite('user1@my.org', roles: ['admin']);
    viewModel.addInvite('user2@my.org', roles: ['guest']);
    await fakeFirestoreWrapper.fake.flush();
    await tester.pump();
    var users = viewModel.listUsers();
    var invites = viewModel.listInvites();
    expect(users.length, equals(2));
    expect(viewModel.listInvites().length, equals(2));
    expect(users[0].userEmail, equals('user1@my.org'));
    expect(users[0].roles.first, equals('admin'));
    expect(invites[1].userEmail, equals('user2@my.org'));
    expect(invites[1].roles.first, equals('guest'));
  });
  testWidgets('remove users/invites', (tester) async {
    var fakeFirestoreWrapper = FakeFirestoreWrapper();
    await fakeFirestoreWrapper.fake.collection('users').doc('user1').set({
      'email': 'user1@my.org',
      'roles': ['admin'],
    });
    await fakeFirestoreWrapper.fake.collection('users').doc('user2').set({
      'email': 'user2@my.org',
      'roles': ['guest'],
    });
    await fakeFirestoreWrapper.fake.collection('invites').doc('invite1').set({
      'email': 'user1@my.org',
      'roles': ['admin'],
    });
    await fakeFirestoreWrapper.fake.collection('invites').doc('invite2').set({
      'email': 'user2@my.org',
      'roles': ['guest'],
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
    expect(users[0].roles.first, equals('admin'));
    expect(invites[0].userEmail, equals('user2@my.org'));
    expect(invites[0].roles.first, equals('guest'));
  });
}
