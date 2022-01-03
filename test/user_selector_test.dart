import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tourbillauth/app_user.dart';
import 'package:tourbillauth/user_selector.dart';
import 'package:tourbillauth/user_selector_model.dart';
import 'package:tourbillauth/libloc.dart';

import 'user_selector_test.mocks.dart';

@GenerateMocks([UserSelectorModel])
void main() {
  testWidgets('find users', (tester) async {
    final viewModel = MockUserSelectorModel();
    when(viewModel.findUsers('to')).thenReturn([
      AppUser(uid: 'toto', email: 'toto@my.org'),
      AppUser(uid: 'total', email: 'total@my.org', description: 'Total Recall'),
    ]);
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: [
          LibLocalizations.delegate,
        ],
        home: Material(
          child: UserSelector(
            viewModel,
            onUserSelected: (_) {},
          ),
        ),
      ),
    );
    await tester.enterText(find.byType(TextFormField), 'to');
    await tester.pump();
    expect(find.text('toto'), findsNothing);
    expect(find.text('toto@my.org'), findsOneWidget);
    expect(find.text('total'), findsNothing);
    expect(find.text('total@my.org'), findsNothing);
    expect(find.text('Total Recall'), findsOneWidget);
    verify(viewModel.findUsers('to'));
  });
}
