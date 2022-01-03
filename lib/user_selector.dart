import 'package:flutter/material.dart';
import 'package:tourbillon/search_field.dart';

import 'app_user.dart';
import 'libloc.dart';
import 'user_selector_model.dart';

/// A widget that allows to search for and select a user.
///
/// This widget requires a [UserSelectorModel] to be passed in the constructor.
/// This widget also requires a [Material] ancestor.
class UserSelector extends StatelessWidget {
  final UserSelectorModel viewModel;
  final void Function(AppUser) onUserSelected;

  const UserSelector(
    this.viewModel, {
    required this.onUserSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Listen to directory manager

    return SearchField<AppUser>(
      hint: libloc(context).searchUserLabel,
      getResults: (query) => viewModel.findUsers(query),
      onSelectResult: (userResult) => onUserSelected(userResult),
    );
  }
}
