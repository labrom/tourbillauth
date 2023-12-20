import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tourbillon/firestore.dart';

import 'config.dart';
import 'model.dart';

part 'auth.g.dart';

@riverpod
FirebaseAuth firebaseAuth(_) => FirebaseAuth.instance;

@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) =>
    ref.watch(firebaseAuthProvider).authStateChanges();

@riverpod
User? user(UserRef ref) => ref.watch(firebaseAuthProvider).currentUser;

@riverpod
String? userId(UserIdRef ref) => ref.watch(userProvider)?.uid;

@riverpod
Future<AppUser?> appUser(AppUserRef ref) async {
  return ref.watch(authStateChangesProvider).when(
      data: (user) async {
        if (user != null) {
          final doc = ref
              .read(firebaseFirestoreProvider)
              .collection(ref.read(userCollectionNameProvider))
              .doc(ref.watch(userIdProvider));
          final snapshot = await doc.get();
          if (!snapshot.exists) {
            final user = ref.watch(userProvider);
            if (user != null) {
              doc.set({
                'email': user.email,
              }, SetOptions(merge: true));
            }
          }
          return AppUser(uid: user.uid, email: user.email ?? '');
        } else {
          return null;
        }
      },
      loading: () => null,
      error: (err, stack) => null);
}
