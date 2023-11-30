import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tourbillon/firestore.dart';

import 'config.dart';

part 'auth.g.dart';

@riverpod
FirebaseAuth firebaseAuth(_) => FirebaseAuth.instance;

final authStateChangesProvider = StreamProvider.autoDispose<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

@riverpod
String? userId(_) => FirebaseAuth.instance.currentUser?.uid;

@riverpod
Future<List<String>> userRoles(UserRolesRef ref) async {
  final snapshot = await ref
      .read(firebaseFirestoreProvider)
      .collection(ref.read(userCollectionNameProvider))
      .doc(ref.watch(userIdProvider))
      .get();
  return snapshot.getListOf<String>(ref.read(rolesFieldNameProvider));
}
