import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tourbillon/firestore.dart';

import 'config.dart';
import 'model.dart';

part 'auth.g.dart';

@riverpod
FirebaseFirestore userFirestore(Ref ref) => ref.read(firebaseFirestoreProvider(
    database: ref.read(usersFirestoreDatabaseNameProvider)));

@riverpod
DocumentReference userFirestoreDocumentReference(Ref ref) =>
    ref.read(userFirestoreProvider).doc(
        '${ref.read(usersCollectionNameProvider)}/${ref.watch(userIdProvider)}');

@riverpod
FirebaseAuth firebaseAuth(_) => FirebaseAuth.instance;

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
User? user(Ref ref) => ref.watch(firebaseAuthProvider).currentUser;

@riverpod
String? userId(Ref ref) => ref.watch(userProvider)?.uid;

@riverpod
Future<AppUser?> appUser(Ref ref) async {
  return ref.watch(authStateChangesProvider).when(
      data: (user) async {
        if (user != null) {
          final doc = ref.watch(userFirestoreDocumentReferenceProvider);
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
