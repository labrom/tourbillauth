import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'app_user.dart';
import 'directory_manager.dart';

/// A view model for searching users.
///
/// This view model requires a [DirectoryManager] to be present in the context.
///
/// This class is a [ChangeNotifier] so clients can be notified when the underlying
/// data changes.
class UserSelectorModel with ChangeNotifier {
  final DirectoryManager _directory;

  UserSelectorModel(BuildContext context)
      : _directory = context.read<DirectoryManager>() {
    _directory.addListener(() => notifyListeners());
    _directory.loadUsers();
  }

  List<AppUser> findUsers(String query) => _directory.findUsers(query);
}
