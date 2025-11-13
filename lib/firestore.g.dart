// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$userSpacePathHash() => r'4a9a718ba91265770eb721020d6ac7f7e003b129';

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
    r'727d97771e1044ce28d963b70bfea0b39fcf6b46';

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
    r'eee80bd3e554bfaa6353533cedbc4153f95d6651';

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

String _$userSpaceDocumentHash() => r'00d7824d60931cd77cb764549dd902b960051715';

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

@ProviderFor(userSpaceDocumentStream)
const userSpaceDocumentStreamProvider = UserSpaceDocumentStreamFamily._();

final class UserSpaceDocumentStreamProvider extends $FunctionalProvider<
        AsyncValue<QuerySnapshot<Object?>>,
        QuerySnapshot<Object?>,
        Stream<QuerySnapshot<Object?>>>
    with
        $FutureModifier<QuerySnapshot<Object?>>,
        $StreamProvider<QuerySnapshot<Object?>> {
  const UserSpaceDocumentStreamProvider._(
      {required UserSpaceDocumentStreamFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'userSpaceDocumentStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userSpaceDocumentStreamHash();

  @override
  String toString() {
    return r'userSpaceDocumentStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<QuerySnapshot<Object?>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<QuerySnapshot<Object?>> create(Ref ref) {
    final argument = this.argument as String;
    return userSpaceDocumentStream(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserSpaceDocumentStreamProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userSpaceDocumentStreamHash() =>
    r'417c7862af925aa4d9b6e814b5d30e15981b520e';

final class UserSpaceDocumentStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<QuerySnapshot<Object?>>, String> {
  const UserSpaceDocumentStreamFamily._()
      : super(
          retry: null,
          name: r'userSpaceDocumentStreamProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserSpaceDocumentStreamProvider call(
    String collectionPath,
  ) =>
      UserSpaceDocumentStreamProvider._(argument: collectionPath, from: this);

  @override
  String toString() => r'userSpaceDocumentStreamProvider';
}
