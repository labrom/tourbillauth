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
}
