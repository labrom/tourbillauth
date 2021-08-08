import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tourbillauth/user_management_view_model.dart';
import 'package:tourbillon/fake_firestore.dart';
import 'package:tourbillon/firestore.dart';

void main() {
  testWidgets('List users/invites', (tester) async {
    var fakeFirestoreWrapper = FakeFirestoreWrapper();
    await fakeFirestoreWrapper.fake.collection('users').doc('user2').set({
      'email': 'user2@my.org',
      'role': 'guest',
    });
    await fakeFirestoreWrapper.fake.collection('users').doc('user1').set({
      'email': 'user1@my.org',
      'role': 'admin',
    });
    await fakeFirestoreWrapper.fake
        .collection('invites')
        .doc('user2@my.org')
        .set({
      'role': 'guest',
    });
    await fakeFirestoreWrapper.fake
        .collection('invites')
        .doc('user1@my.org')
        .set({
      'role': 'admin',
    });
    late UserManagementViewModel viewModel;
    await tester.pumpWidget(Provider<FirestoreInterface>.value(
      value: fakeFirestoreWrapper,
      child: ChangeNotifierProvider(
        create: (context) {
          viewModel = UserManagementViewModel.firestore(context);
          return viewModel;
        },
        lazy: false,
        child: Container(),
      ),
    ));
    expect(viewModel.listUsers().length, equals(2));
    expect(viewModel.listInvites().length, equals(2));
    expect(viewModel.listUsers()[0].userEmail, equals('user1@my.org'));
    expect(viewModel.listUsers()[0].role, equals('admin'));
    expect(viewModel.listInvites()[1].userEmail, equals('user2@my.org'));
    expect(viewModel.listInvites()[1].role, equals('guest'));
  });
  testWidgets('List users and invites', (tester) async {
    var fakeFirestoreWrapper = FakeFirestoreWrapper();
    await fakeFirestoreWrapper.fake.collection('users').doc('user4').set({
      'email': 'user4@my.org',
    });
    await fakeFirestoreWrapper.fake.collection('users').doc('user2').set({
      'email': 'user2@my.org',
    });
    await fakeFirestoreWrapper.fake
        .collection('invites')
        .doc('user2@my.org')
        .set({});
    await fakeFirestoreWrapper.fake
        .collection('invites')
        .doc('user3@my.org')
        .set({});
    late UserManagementViewModel viewModel;
    await tester.pumpWidget(Provider<FirestoreInterface>.value(
      value: fakeFirestoreWrapper,
      child: ChangeNotifierProvider(
        create: (context) {
          viewModel = UserManagementViewModel.firestore(context);
          return viewModel;
        },
        lazy: false,
        child: Container(),
      ),
    ));
    expect(viewModel.listUsersAndInvites().length, equals(3));
    expect(
        viewModel.listUsersAndInvites()[0].userEmail, equals('user2@my.org'));
    expect(
        viewModel.listUsersAndInvites()[1].userEmail, equals('user3@my.org'));
    expect(
        viewModel.listUsersAndInvites()[2].userEmail, equals('user4@my.org'));
  });
  testWidgets('Add users/invites', (tester) async {
    var fakeFirestoreWrapper = FakeFirestoreWrapper();
    late UserManagementViewModel viewModel;
    await tester.pumpWidget(Provider<FirestoreInterface>.value(
      value: fakeFirestoreWrapper,
      child: ChangeNotifierProvider(
        create: (context) {
          viewModel = UserManagementViewModel.firestore(context);
          return viewModel;
        },
        lazy: false,
        child: Container(),
      ),
    ));
    await viewModel.addUser('user1', email: 'user1@my.org', role: 'admin');
    await viewModel.addUser('user2', email: 'user2@my.org', role: 'guest');
    await viewModel.addInvite('user1@my.org', role: 'admin');
    await viewModel.addInvite('user2@my.org', role: 'guest');
    await fakeFirestoreWrapper.fake.flush();
    expect(viewModel.listUsers().length, equals(2));
    expect(viewModel.listInvites().length, equals(2));
    expect(viewModel.listUsers()[0].userEmail, equals('user1@my.org'));
    expect(viewModel.listUsers()[0].role, equals('admin'));
    expect(viewModel.listInvites()[1].userEmail, equals('user2@my.org'));
    expect(viewModel.listInvites()[1].role, equals('guest'));
  });
  testWidgets('Remove users/invites', (tester) async {
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
    late UserManagementViewModel viewModel;
    await tester.pumpWidget(Provider<FirestoreInterface>.value(
      value: fakeFirestoreWrapper,
      child: ChangeNotifierProvider(
        create: (context) {
          viewModel = UserManagementViewModel.firestore(context);
          return viewModel;
        },
        lazy: false,
        child: Container(),
      ),
    ));
    await viewModel.removeUser('user2');
    await viewModel.removeInvite('user1@my.org');
    await fakeFirestoreWrapper.fake.flush();
    expect(viewModel.listUsers().length, equals(1));
    expect(viewModel.listInvites().length, equals(1));
    expect(viewModel.listUsers()[0].userEmail, equals('user1@my.org'));
    expect(viewModel.listUsers()[0].role, equals('admin'));
    expect(viewModel.listInvites()[0].userEmail, equals('user2@my.org'));
    expect(viewModel.listInvites()[0].role, equals('guest'));
  });
}
