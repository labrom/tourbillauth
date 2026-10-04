import 'model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:tourbillauth/firestore.dart';

part 'auth.g.dart';

@riverpod
FirebaseAuth firebaseAuth(Ref ref) => FirebaseAuth.instance;

@riverpod
Stream<User?> authStateChanges(Ref ref) =>
    ref.watch(firebaseAuthProvider).authStateChanges();

@riverpod
Raw<Stream<User?>> authStateChangesStream(Ref ref) =>
    ref.watch(firebaseAuthProvider).authStateChanges();

@riverpod
Stream<User?> idTokenChanges(Ref ref) =>
    ref.watch(firebaseAuthProvider).idTokenChanges();

@riverpod
User? user(Ref ref) => ref.watch(authStateChangesProvider).value;

@riverpod
String? userId(Ref ref) => ref.watch(userProvider)?.uid;

@riverpod
Future<AppUser?> appUser(Ref ref) async {
  return ref.watch(authStateChangesProvider).when(
        data: (user) async {
          if (user == null) return null;

          final doc = userFirestoreDocumentReference(ref);
          final snapshot = await doc.get();
          if (!snapshot.exists) {
            await doc.set({
              'email': user.email,
            }, SetOptions(merge: true));
          }
          return AppUser(uid: user.uid, email: user.email ?? '');
        },
        loading: () => null,
        error: (err, stack) => null,
      );
}
