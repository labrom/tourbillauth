import 'dart:collection';

class AppUser {
  final String uid;
  final String email;
  final String? description;

  AppUser({
    required this.uid,
    required this.email,
    this.description,
  });

  bool matches(List<String> searchTerms) {
    if (searchTerms.isEmpty) return false;
    for (var term in searchTerms) {
      if (email.contains(term) != true &&
          description?.contains(term) != true &&
          uid != term) return false;
    }
    return true;
  }

  @override
  String toString() => description ?? email;
}

mixin UserRole {
  /// User's email address.
  late String userEmail;

  /// Set of user's roles.
  ///
  /// Roles are sorted in alphabetical order.
  final Set<String> roles = SplayTreeSet();

  /// User's Firebase UID.
  String? get userId;
}

class AppUserRole extends AppUser with UserRole {
  AppUserRole(
    String userId,
    String userEmail, {
    String? userDisplay,
    List<String>? roles,
  }) : super(
            uid: userId,
            email: userEmail,
            description: userDisplay ?? userEmail) {
    this.userEmail = userEmail;
    if (roles != null) {
      this.roles.addAll(roles);
    }
  }

  @override
  String? get userId => uid;
}

class InviteRole with UserRole {
  String? docId;
  InviteRole({
    required String userEmail,
    this.docId,
    List<String>? roles,
  }) {
    this.userEmail = userEmail;
    if (roles != null) {
      this.roles.addAll(roles);
    }
  }

  @override
  String? get userId => null;
}
