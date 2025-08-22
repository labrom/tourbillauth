// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userSpacePathHash() => r'4a9a718ba91265770eb721020d6ac7f7e003b129';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [userSpacePath].
@ProviderFor(userSpacePath)
const userSpacePathProvider = UserSpacePathFamily();

/// See also [userSpacePath].
class UserSpacePathFamily extends Family<String> {
  /// See also [userSpacePath].
  const UserSpacePathFamily();

  /// See also [userSpacePath].
  UserSpacePathProvider call(
    String path,
  ) {
    return UserSpacePathProvider(
      path,
    );
  }

  @override
  UserSpacePathProvider getProviderOverride(
    covariant UserSpacePathProvider provider,
  ) {
    return call(
      provider.path,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userSpacePathProvider';
}

/// See also [userSpacePath].
class UserSpacePathProvider extends AutoDisposeProvider<String> {
  /// See also [userSpacePath].
  UserSpacePathProvider(
    String path,
  ) : this._internal(
          (ref) => userSpacePath(
            ref as UserSpacePathRef,
            path,
          ),
          from: userSpacePathProvider,
          name: r'userSpacePathProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userSpacePathHash,
          dependencies: UserSpacePathFamily._dependencies,
          allTransitiveDependencies:
              UserSpacePathFamily._allTransitiveDependencies,
          path: path,
        );

  UserSpacePathProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
  }) : super.internal();

  final String path;

  @override
  Override overrideWith(
    String Function(UserSpacePathRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserSpacePathProvider._internal(
        (ref) => create(ref as UserSpacePathRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _UserSpacePathProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserSpacePathProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserSpacePathRef on AutoDisposeProviderRef<String> {
  /// The parameter `path` of this provider.
  String get path;
}

class _UserSpacePathProviderElement extends AutoDisposeProviderElement<String>
    with UserSpacePathRef {
  _UserSpacePathProviderElement(super.provider);

  @override
  String get path => (origin as UserSpacePathProvider).path;
}

String _$userSpaceCollectionReferenceHash() =>
    r'727d97771e1044ce28d963b70bfea0b39fcf6b46';

/// See also [userSpaceCollectionReference].
@ProviderFor(userSpaceCollectionReference)
const userSpaceCollectionReferenceProvider =
    UserSpaceCollectionReferenceFamily();

/// See also [userSpaceCollectionReference].
class UserSpaceCollectionReferenceFamily
    extends Family<CollectionReference<Map<String, dynamic>>> {
  /// See also [userSpaceCollectionReference].
  const UserSpaceCollectionReferenceFamily();

  /// See also [userSpaceCollectionReference].
  UserSpaceCollectionReferenceProvider call(
    String path,
  ) {
    return UserSpaceCollectionReferenceProvider(
      path,
    );
  }

  @override
  UserSpaceCollectionReferenceProvider getProviderOverride(
    covariant UserSpaceCollectionReferenceProvider provider,
  ) {
    return call(
      provider.path,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userSpaceCollectionReferenceProvider';
}

/// See also [userSpaceCollectionReference].
class UserSpaceCollectionReferenceProvider
    extends AutoDisposeProvider<CollectionReference<Map<String, dynamic>>> {
  /// See also [userSpaceCollectionReference].
  UserSpaceCollectionReferenceProvider(
    String path,
  ) : this._internal(
          (ref) => userSpaceCollectionReference(
            ref as UserSpaceCollectionReferenceRef,
            path,
          ),
          from: userSpaceCollectionReferenceProvider,
          name: r'userSpaceCollectionReferenceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userSpaceCollectionReferenceHash,
          dependencies: UserSpaceCollectionReferenceFamily._dependencies,
          allTransitiveDependencies:
              UserSpaceCollectionReferenceFamily._allTransitiveDependencies,
          path: path,
        );

  UserSpaceCollectionReferenceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
  }) : super.internal();

  final String path;

  @override
  Override overrideWith(
    CollectionReference<Map<String, dynamic>> Function(
            UserSpaceCollectionReferenceRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserSpaceCollectionReferenceProvider._internal(
        (ref) => create(ref as UserSpaceCollectionReferenceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<CollectionReference<Map<String, dynamic>>>
      createElement() {
    return _UserSpaceCollectionReferenceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserSpaceCollectionReferenceProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserSpaceCollectionReferenceRef
    on AutoDisposeProviderRef<CollectionReference<Map<String, dynamic>>> {
  /// The parameter `path` of this provider.
  String get path;
}

class _UserSpaceCollectionReferenceProviderElement
    extends AutoDisposeProviderElement<
        CollectionReference<Map<String, dynamic>>>
    with UserSpaceCollectionReferenceRef {
  _UserSpaceCollectionReferenceProviderElement(super.provider);

  @override
  String get path => (origin as UserSpaceCollectionReferenceProvider).path;
}

String _$userSpaceDocumentReferenceHash() =>
    r'eee80bd3e554bfaa6353533cedbc4153f95d6651';

/// See also [userSpaceDocumentReference].
@ProviderFor(userSpaceDocumentReference)
const userSpaceDocumentReferenceProvider = UserSpaceDocumentReferenceFamily();

/// See also [userSpaceDocumentReference].
class UserSpaceDocumentReferenceFamily
    extends Family<DocumentReference<Map<String, dynamic>>> {
  /// See also [userSpaceDocumentReference].
  const UserSpaceDocumentReferenceFamily();

  /// See also [userSpaceDocumentReference].
  UserSpaceDocumentReferenceProvider call(
    String path,
  ) {
    return UserSpaceDocumentReferenceProvider(
      path,
    );
  }

  @override
  UserSpaceDocumentReferenceProvider getProviderOverride(
    covariant UserSpaceDocumentReferenceProvider provider,
  ) {
    return call(
      provider.path,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userSpaceDocumentReferenceProvider';
}

/// See also [userSpaceDocumentReference].
class UserSpaceDocumentReferenceProvider
    extends AutoDisposeProvider<DocumentReference<Map<String, dynamic>>> {
  /// See also [userSpaceDocumentReference].
  UserSpaceDocumentReferenceProvider(
    String path,
  ) : this._internal(
          (ref) => userSpaceDocumentReference(
            ref as UserSpaceDocumentReferenceRef,
            path,
          ),
          from: userSpaceDocumentReferenceProvider,
          name: r'userSpaceDocumentReferenceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userSpaceDocumentReferenceHash,
          dependencies: UserSpaceDocumentReferenceFamily._dependencies,
          allTransitiveDependencies:
              UserSpaceDocumentReferenceFamily._allTransitiveDependencies,
          path: path,
        );

  UserSpaceDocumentReferenceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
  }) : super.internal();

  final String path;

  @override
  Override overrideWith(
    DocumentReference<Map<String, dynamic>> Function(
            UserSpaceDocumentReferenceRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserSpaceDocumentReferenceProvider._internal(
        (ref) => create(ref as UserSpaceDocumentReferenceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<DocumentReference<Map<String, dynamic>>>
      createElement() {
    return _UserSpaceDocumentReferenceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserSpaceDocumentReferenceProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserSpaceDocumentReferenceRef
    on AutoDisposeProviderRef<DocumentReference<Map<String, dynamic>>> {
  /// The parameter `path` of this provider.
  String get path;
}

class _UserSpaceDocumentReferenceProviderElement
    extends AutoDisposeProviderElement<DocumentReference<Map<String, dynamic>>>
    with UserSpaceDocumentReferenceRef {
  _UserSpaceDocumentReferenceProviderElement(super.provider);

  @override
  String get path => (origin as UserSpaceDocumentReferenceProvider).path;
}

String _$userSpaceDocumentHash() => r'00d7824d60931cd77cb764549dd902b960051715';

/// See also [userSpaceDocument].
@ProviderFor(userSpaceDocument)
const userSpaceDocumentProvider = UserSpaceDocumentFamily();

/// See also [userSpaceDocument].
class UserSpaceDocumentFamily
    extends Family<AsyncValue<DocumentSnapshot<Map<String, dynamic>>>> {
  /// See also [userSpaceDocument].
  const UserSpaceDocumentFamily();

  /// See also [userSpaceDocument].
  UserSpaceDocumentProvider call(
    String path,
  ) {
    return UserSpaceDocumentProvider(
      path,
    );
  }

  @override
  UserSpaceDocumentProvider getProviderOverride(
    covariant UserSpaceDocumentProvider provider,
  ) {
    return call(
      provider.path,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userSpaceDocumentProvider';
}

/// See also [userSpaceDocument].
class UserSpaceDocumentProvider
    extends AutoDisposeStreamProvider<DocumentSnapshot<Map<String, dynamic>>> {
  /// See also [userSpaceDocument].
  UserSpaceDocumentProvider(
    String path,
  ) : this._internal(
          (ref) => userSpaceDocument(
            ref as UserSpaceDocumentRef,
            path,
          ),
          from: userSpaceDocumentProvider,
          name: r'userSpaceDocumentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userSpaceDocumentHash,
          dependencies: UserSpaceDocumentFamily._dependencies,
          allTransitiveDependencies:
              UserSpaceDocumentFamily._allTransitiveDependencies,
          path: path,
        );

  UserSpaceDocumentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
  }) : super.internal();

  final String path;

  @override
  Override overrideWith(
    Stream<DocumentSnapshot<Map<String, dynamic>>> Function(
            UserSpaceDocumentRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserSpaceDocumentProvider._internal(
        (ref) => create(ref as UserSpaceDocumentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<DocumentSnapshot<Map<String, dynamic>>>
      createElement() {
    return _UserSpaceDocumentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserSpaceDocumentProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserSpaceDocumentRef
    on AutoDisposeStreamProviderRef<DocumentSnapshot<Map<String, dynamic>>> {
  /// The parameter `path` of this provider.
  String get path;
}

class _UserSpaceDocumentProviderElement
    extends AutoDisposeStreamProviderElement<
        DocumentSnapshot<Map<String, dynamic>>> with UserSpaceDocumentRef {
  _UserSpaceDocumentProviderElement(super.provider);

  @override
  String get path => (origin as UserSpaceDocumentProvider).path;
}

String _$userSpaceDocumentStreamHash() =>
    r'417c7862af925aa4d9b6e814b5d30e15981b520e';

/// See also [userSpaceDocumentStream].
@ProviderFor(userSpaceDocumentStream)
const userSpaceDocumentStreamProvider = UserSpaceDocumentStreamFamily();

/// See also [userSpaceDocumentStream].
class UserSpaceDocumentStreamFamily extends Family<AsyncValue<QuerySnapshot>> {
  /// See also [userSpaceDocumentStream].
  const UserSpaceDocumentStreamFamily();

  /// See also [userSpaceDocumentStream].
  UserSpaceDocumentStreamProvider call(
    String collectionPath,
  ) {
    return UserSpaceDocumentStreamProvider(
      collectionPath,
    );
  }

  @override
  UserSpaceDocumentStreamProvider getProviderOverride(
    covariant UserSpaceDocumentStreamProvider provider,
  ) {
    return call(
      provider.collectionPath,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userSpaceDocumentStreamProvider';
}

/// See also [userSpaceDocumentStream].
class UserSpaceDocumentStreamProvider
    extends AutoDisposeStreamProvider<QuerySnapshot> {
  /// See also [userSpaceDocumentStream].
  UserSpaceDocumentStreamProvider(
    String collectionPath,
  ) : this._internal(
          (ref) => userSpaceDocumentStream(
            ref as UserSpaceDocumentStreamRef,
            collectionPath,
          ),
          from: userSpaceDocumentStreamProvider,
          name: r'userSpaceDocumentStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userSpaceDocumentStreamHash,
          dependencies: UserSpaceDocumentStreamFamily._dependencies,
          allTransitiveDependencies:
              UserSpaceDocumentStreamFamily._allTransitiveDependencies,
          collectionPath: collectionPath,
        );

  UserSpaceDocumentStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.collectionPath,
  }) : super.internal();

  final String collectionPath;

  @override
  Override overrideWith(
    Stream<QuerySnapshot> Function(UserSpaceDocumentStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserSpaceDocumentStreamProvider._internal(
        (ref) => create(ref as UserSpaceDocumentStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        collectionPath: collectionPath,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<QuerySnapshot> createElement() {
    return _UserSpaceDocumentStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserSpaceDocumentStreamProvider &&
        other.collectionPath == collectionPath;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, collectionPath.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserSpaceDocumentStreamRef
    on AutoDisposeStreamProviderRef<QuerySnapshot> {
  /// The parameter `collectionPath` of this provider.
  String get collectionPath;
}

class _UserSpaceDocumentStreamProviderElement
    extends AutoDisposeStreamProviderElement<QuerySnapshot>
    with UserSpaceDocumentStreamRef {
  _UserSpaceDocumentStreamProviderElement(super.provider);

  @override
  String get collectionPath =>
      (origin as UserSpaceDocumentStreamProvider).collectionPath;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
