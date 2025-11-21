// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userFirestore)
const userFirestoreProvider = UserFirestoreProvider._();

final class UserFirestoreProvider extends $FunctionalProvider<FirebaseFirestore,
    FirebaseFirestore, FirebaseFirestore> with $Provider<FirebaseFirestore> {
  const UserFirestoreProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userFirestoreProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userFirestoreHash();

  @$internal
  @override
  $ProviderElement<FirebaseFirestore> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseFirestore create(Ref ref) {
    return userFirestore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseFirestore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseFirestore>(value),
    );
  }
}

String _$userFirestoreHash() => r'e817a9db592a0cd7a22bc02b4df30155e5665fde';

@ProviderFor(userFirestoreDocumentReference)
const userFirestoreDocumentReferenceProvider =
    UserFirestoreDocumentReferenceProvider._();

final class UserFirestoreDocumentReferenceProvider extends $FunctionalProvider<
    DocumentReference<Object?>,
    DocumentReference<Object?>,
    DocumentReference<Object?>> with $Provider<DocumentReference<Object?>> {
  const UserFirestoreDocumentReferenceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userFirestoreDocumentReferenceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userFirestoreDocumentReferenceHash();

  @$internal
  @override
  $ProviderElement<DocumentReference<Object?>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DocumentReference<Object?> create(Ref ref) {
    return userFirestoreDocumentReference(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentReference<Object?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DocumentReference<Object?>>(value),
    );
  }
}

String _$userFirestoreDocumentReferenceHash() =>
    r'2a0ae86dee2933a6fe396549423b200403153a9f';

@ProviderFor(userSpacePath)
const userSpacePathProvider = UserSpacePathFamily._();

final class UserSpacePathProvider
    extends $FunctionalProvider<String, String, String> with $Provider<String> {
  const UserSpacePathProvider._(
      {required UserSpacePathFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'userSpacePathProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userSpacePathHash();

  @override
  String toString() {
    return r'userSpacePathProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    final argument = this.argument as String;
    return userSpacePath(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserSpacePathProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userSpacePathHash() => r'36df06e7a4afe9dc72d52740e47564a5c91130f8';

final class UserSpacePathFamily extends $Family
    with $FunctionalFamilyOverride<String, String> {
  const UserSpacePathFamily._()
      : super(
          retry: null,
          name: r'userSpacePathProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserSpacePathProvider call(
    String path,
  ) =>
      UserSpacePathProvider._(argument: path, from: this);

  @override
  String toString() => r'userSpacePathProvider';
}

@ProviderFor(userSpaceCollectionReference)
const userSpaceCollectionReferenceProvider =
    UserSpaceCollectionReferenceFamily._();

final class UserSpaceCollectionReferenceProvider extends $FunctionalProvider<
        CollectionReference<Map<String, dynamic>>,
        CollectionReference<Map<String, dynamic>>,
        CollectionReference<Map<String, dynamic>>>
    with $Provider<CollectionReference<Map<String, dynamic>>> {
  const UserSpaceCollectionReferenceProvider._(
      {required UserSpaceCollectionReferenceFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'userSpaceCollectionReferenceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userSpaceCollectionReferenceHash();

  @override
  String toString() {
    return r'userSpaceCollectionReferenceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<CollectionReference<Map<String, dynamic>>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CollectionReference<Map<String, dynamic>> create(Ref ref) {
    final argument = this.argument as String;
    return userSpaceCollectionReference(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionReference<Map<String, dynamic>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<CollectionReference<Map<String, dynamic>>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserSpaceCollectionReferenceProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userSpaceCollectionReferenceHash() =>
    r'388f222cac89cdbfb7ebfac55cedfa9643f1288b';

final class UserSpaceCollectionReferenceFamily extends $Family
    with
        $FunctionalFamilyOverride<CollectionReference<Map<String, dynamic>>,
            String> {
  const UserSpaceCollectionReferenceFamily._()
      : super(
          retry: null,
          name: r'userSpaceCollectionReferenceProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserSpaceCollectionReferenceProvider call(
    String path,
  ) =>
      UserSpaceCollectionReferenceProvider._(argument: path, from: this);

  @override
  String toString() => r'userSpaceCollectionReferenceProvider';
}

@ProviderFor(userSpaceDocumentReference)
const userSpaceDocumentReferenceProvider = UserSpaceDocumentReferenceFamily._();

final class UserSpaceDocumentReferenceProvider extends $FunctionalProvider<
        DocumentReference<Map<String, dynamic>>,
        DocumentReference<Map<String, dynamic>>,
        DocumentReference<Map<String, dynamic>>>
    with $Provider<DocumentReference<Map<String, dynamic>>> {
  const UserSpaceDocumentReferenceProvider._(
      {required UserSpaceDocumentReferenceFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'userSpaceDocumentReferenceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userSpaceDocumentReferenceHash();

  @override
  String toString() {
    return r'userSpaceDocumentReferenceProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<DocumentReference<Map<String, dynamic>>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DocumentReference<Map<String, dynamic>> create(Ref ref) {
    final argument = this.argument as String;
    return userSpaceDocumentReference(
      ref,
      argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentReference<Map<String, dynamic>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<DocumentReference<Map<String, dynamic>>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserSpaceDocumentReferenceProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userSpaceDocumentReferenceHash() =>
    r'b71feb6aff1f28aff5c67d7c8983004326e7cb33';

final class UserSpaceDocumentReferenceFamily extends $Family
    with
        $FunctionalFamilyOverride<DocumentReference<Map<String, dynamic>>,
            String> {
  const UserSpaceDocumentReferenceFamily._()
      : super(
          retry: null,
          name: r'userSpaceDocumentReferenceProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserSpaceDocumentReferenceProvider call(
    String path,
  ) =>
      UserSpaceDocumentReferenceProvider._(argument: path, from: this);

  @override
  String toString() => r'userSpaceDocumentReferenceProvider';
}

@ProviderFor(userSpaceDocument)
const userSpaceDocumentProvider = UserSpaceDocumentFamily._();

final class UserSpaceDocumentProvider extends $FunctionalProvider<
        AsyncValue<DocumentSnapshot<Map<String, dynamic>>>,
        DocumentSnapshot<Map<String, dynamic>>,
        Stream<DocumentSnapshot<Map<String, dynamic>>>>
    with
        $FutureModifier<DocumentSnapshot<Map<String, dynamic>>>,
        $StreamProvider<DocumentSnapshot<Map<String, dynamic>>> {
  const UserSpaceDocumentProvider._(
      {required UserSpaceDocumentFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'userSpaceDocumentProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userSpaceDocumentHash();

  @override
  String toString() {
    return r'userSpaceDocumentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<DocumentSnapshot<Map<String, dynamic>>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as String;
    return userSpaceDocument(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserSpaceDocumentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userSpaceDocumentHash() => r'bc33198b5592083d102419bb9eb525c065ac2227';

final class UserSpaceDocumentFamily extends $Family
    with
        $FunctionalFamilyOverride<
            Stream<DocumentSnapshot<Map<String, dynamic>>>, String> {
  const UserSpaceDocumentFamily._()
      : super(
          retry: null,
          name: r'userSpaceDocumentProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserSpaceDocumentProvider call(
    String path,
  ) =>
      UserSpaceDocumentProvider._(argument: path, from: this);

  @override
  String toString() => r'userSpaceDocumentProvider';
}

@ProviderFor(userSpaceQueryStream)
const userSpaceQueryStreamProvider = UserSpaceQueryStreamFamily._();

final class UserSpaceQueryStreamProvider extends $FunctionalProvider<
        AsyncValue<QuerySnapshot<Map<String, dynamic>>>,
        QuerySnapshot<Map<String, dynamic>>,
        Stream<QuerySnapshot<Map<String, dynamic>>>>
    with
        $FutureModifier<QuerySnapshot<Map<String, dynamic>>>,
        $StreamProvider<QuerySnapshot<Map<String, dynamic>>> {
  const UserSpaceQueryStreamProvider._(
      {required UserSpaceQueryStreamFamily super.from,
      required (
        String, {
        OrderBy? orderBy,
      })
          super.argument})
      : super(
          retry: null,
          name: r'userSpaceQueryStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userSpaceQueryStreamHash();

  @override
  String toString() {
    return r'userSpaceQueryStreamProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<QuerySnapshot<Map<String, dynamic>>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as (
      String, {
      OrderBy? orderBy,
    });
    return userSpaceQueryStream(
      ref,
      argument.$1,
      orderBy: argument.orderBy,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserSpaceQueryStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userSpaceQueryStreamHash() =>
    r'ffe811f3a1e65426194df21729586d4b31cf59d2';

final class UserSpaceQueryStreamFamily extends $Family
    with
        $FunctionalFamilyOverride<
            Stream<QuerySnapshot<Map<String, dynamic>>>,
            (
              String, {
              OrderBy? orderBy,
            })> {
  const UserSpaceQueryStreamFamily._()
      : super(
          retry: null,
          name: r'userSpaceQueryStreamProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserSpaceQueryStreamProvider call(
    String collectionPath, {
    OrderBy? orderBy,
  }) =>
      UserSpaceQueryStreamProvider._(argument: (
        collectionPath,
        orderBy: orderBy,
      ), from: this);

  @override
  String toString() => r'userSpaceQueryStreamProvider';
}

@ProviderFor(userSpaceQueryDocumentList)
const userSpaceQueryDocumentListProvider = UserSpaceQueryDocumentListFamily._();

final class UserSpaceQueryDocumentListProvider extends $FunctionalProvider<
        AsyncValue<List<QueryDocumentSnapshot<Map<String, dynamic>>>>,
        List<QueryDocumentSnapshot<Map<String, dynamic>>>,
        FutureOr<List<QueryDocumentSnapshot<Map<String, dynamic>>>>>
    with
        $FutureModifier<List<QueryDocumentSnapshot<Map<String, dynamic>>>>,
        $FutureProvider<List<QueryDocumentSnapshot<Map<String, dynamic>>>> {
  const UserSpaceQueryDocumentListProvider._(
      {required UserSpaceQueryDocumentListFamily super.from,
      required (
        String, {
        OrderBy? orderBy,
      })
          super.argument})
      : super(
          retry: null,
          name: r'userSpaceQueryDocumentListProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userSpaceQueryDocumentListHash();

  @override
  String toString() {
    return r'userSpaceQueryDocumentListProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      $createElement($ProviderPointer pointer) =>
          $FutureProviderElement(pointer);

  @override
  FutureOr<List<QueryDocumentSnapshot<Map<String, dynamic>>>> create(Ref ref) {
    final argument = this.argument as (
      String, {
      OrderBy? orderBy,
    });
    return userSpaceQueryDocumentList(
      ref,
      argument.$1,
      orderBy: argument.orderBy,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserSpaceQueryDocumentListProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userSpaceQueryDocumentListHash() =>
    r'1328e6d966af53e0e5f9775c417d0a4f04d8bd30';

final class UserSpaceQueryDocumentListFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<List<QueryDocumentSnapshot<Map<String, dynamic>>>>,
            (
              String, {
              OrderBy? orderBy,
            })> {
  const UserSpaceQueryDocumentListFamily._()
      : super(
          retry: null,
          name: r'userSpaceQueryDocumentListProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserSpaceQueryDocumentListProvider call(
    String collectionPath, {
    OrderBy? orderBy,
  }) =>
      UserSpaceQueryDocumentListProvider._(argument: (
        collectionPath,
        orderBy: orderBy,
      ), from: this);

  @override
  String toString() => r'userSpaceQueryDocumentListProvider';
}
