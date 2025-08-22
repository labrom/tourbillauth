import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tourbillauth/auth.dart';
import 'package:tourbillauth/config.dart';

part 'firestore.g.dart';

@riverpod
String userSpacePath(Ref ref, String path) =>
    '${ref.read(usersCollectionNameProvider)}/${userId(ref)}/$path';

@riverpod
CollectionReference<Map<String, dynamic>> userSpaceCollectionReference(Ref ref, String path) {
  return ref.read(userFirestoreProvider).collection(ref.watch(userSpacePathProvider(path)));
}

@riverpod
DocumentReference<Map<String, dynamic>> userSpaceDocumentReference(Ref ref, String path) {
  return ref.read(userFirestoreProvider).doc(ref.watch(userSpacePathProvider(path)));
}

@riverpod
Stream<DocumentSnapshot<Map<String, dynamic>>> userSpaceDocument(Ref ref, String path) {
  return ref.watch(userSpaceDocumentReferenceProvider(path)).snapshots();
}

@riverpod
Stream<QuerySnapshot> userSpaceDocumentStream(Ref ref, String collectionPath) {
  return ref.watch(userSpaceCollectionReferenceProvider(collectionPath)).snapshots();
}
