import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tourbillauth/auth.dart';
import 'package:tourbillauth/config.dart';
import 'package:tourbillon/firestore.dart';

part 'firestore.g.dart';

@riverpod
FirebaseFirestore userFirestore(Ref ref) => ref.read(firebaseFirestoreProvider(
    database: ref.read(usersFirestoreDatabaseNameProvider)));

@riverpod
DocumentReference userFirestoreDocumentReference(Ref ref) => userFirestore(ref)
    .doc('${usersCollectionName(ref)}/${ref.watch(userIdProvider)}');

@riverpod
String userSpacePath(Ref ref, String path) =>
    '${usersCollectionName(ref)}/${userId(ref)}/$path';

@riverpod
CollectionReference<Map<String, dynamic>> userSpaceCollectionReference(
    Ref ref, String path) {
  return userFirestore(ref).collection(userSpacePath(ref, path));
}

@riverpod
DocumentReference<Map<String, dynamic>> userSpaceDocumentReference(
    Ref ref, String path) {
  return userFirestore(ref).doc(userSpacePath(ref, path));
}

@riverpod
Stream<DocumentSnapshot<Map<String, dynamic>>> userSpaceDocument(
    Ref ref, String path) {
  return userSpaceDocumentReference(ref, path).snapshots();
}

@riverpod
Stream<QuerySnapshot<Map<String, dynamic>>> userSpaceQueryStream(
        Ref ref, String collectionPath, {OrderBy? orderBy}) =>
    firestoreQueryStream(ref, userSpacePath(ref, collectionPath),
        database: ref.read(usersFirestoreDatabaseNameProvider),
        orderBy: orderBy);

@riverpod
Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
    userSpaceQueryDocumentList(Ref ref, String collectionPath,
            {OrderBy? orderBy}) async =>
        firestoreQueryDocumentList(ref, userSpacePath(ref, collectionPath),
            database: ref.read(usersFirestoreDatabaseNameProvider),
            orderBy: orderBy);
