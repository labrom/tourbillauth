import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'app_user.dart';
import 'user_directory.dart';

/// A view model for searching users.
///
/// This view model requires a [UserDirectory] to be present in the context.
///
/// This class is a [ChangeNotifier] so clients can be notified when the underlying
/// data changes.
class UserSelectorModel with ChangeNotifier {
  final UserDirectory _directory;

  UserSelectorModel(BuildContext context)
      : _directory = context.read<UserDirectory>() {
    _directory.addListener(() => notifyListeners());
    _directory.loadUsers();
  }

  List<AppUser> findUsers(String query) => _directory.findUsers(query);
}
