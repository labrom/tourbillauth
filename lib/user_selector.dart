import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourbillon/search_field.dart';

import 'app_user.dart';
import 'directory_manager.dart';
import 'libloc.dart';

/// A widget that allows to search for and select a user.
class UserSelector extends StatelessWidget {
  final void Function(AppUser) onUserSelected;

  UserSelector(
    this.onUserSelected, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Listen to directory manager
    Provider.of<DirectoryManager>(context).loadUsers();

    return SearchField<AppUser>(
      hint: libloc(context).searchUserLabel,
      getResults: (query) =>
          Provider.of<DirectoryManager>(context, listen: false)
              .findUsers(query),
      onSelectResult: (userResult) => onUserSelected(userResult),
    );
  }
}
