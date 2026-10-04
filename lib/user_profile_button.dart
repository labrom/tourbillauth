import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:material_ui/material_ui.dart';

/// A button that displays the current user's profile photo or initial.
///
/// Navigation remains the responsibility of the consuming app through
/// [onPressed].
class UserProfileButton extends ConsumerWidget {
  const UserProfileButton({
    required this.onPressed,
    super.key,
    this.tooltip,
  });

  final VoidCallback? onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: _UserAvatar(user: user),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    final description = _description;
    final fallback = CircleAvatar(
      radius: 16,
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
      child: description.isEmpty
          ? const Icon(Icons.person_rounded, size: 20)
          : Text(description.characters.first.toUpperCase()),
    );
    final photoUrl = user?.photoURL?.trim() ?? '';

    return photoUrl.isEmpty
        ? fallback
        : ClipOval(
            child: Image.network(
              photoUrl,
              width: 32,
              height: 32,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => fallback,
            ),
          );
  }

  String get _description {
    final displayName = user?.displayName?.trim() ?? '';
    if (displayName.isNotEmpty) return displayName;
    return user?.email?.trim() ?? '';
  }
}
