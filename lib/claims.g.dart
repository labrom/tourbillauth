// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claims.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$setClaimsHash() => r'e400a82f24a531e60b7bf1cf7f17c440dd19c9e8';

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

/// See also [setClaims].
@ProviderFor(setClaims)
const setClaimsProvider = SetClaimsFamily();

/// See also [setClaims].
class SetClaimsFamily extends Family<AsyncValue<bool>> {
  /// See also [setClaims].
  const SetClaimsFamily();

  /// See also [setClaims].
  SetClaimsProvider call(
    String resource,
  ) {
    return SetClaimsProvider(
      resource,
    );
  }

  @override
  SetClaimsProvider getProviderOverride(
    covariant SetClaimsProvider provider,
  ) {
    return call(
      provider.resource,
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
  String? get name => r'setClaimsProvider';
}

/// See also [setClaims].
class SetClaimsProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [setClaims].
  SetClaimsProvider(
    String resource,
  ) : this._internal(
          (ref) => setClaims(
            ref as SetClaimsRef,
            resource,
          ),
          from: setClaimsProvider,
          name: r'setClaimsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setClaimsHash,
          dependencies: SetClaimsFamily._dependencies,
          allTransitiveDependencies: SetClaimsFamily._allTransitiveDependencies,
          resource: resource,
        );

  SetClaimsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.resource,
  }) : super.internal();

  final String resource;

  @override
  Override overrideWith(
    FutureOr<bool> Function(SetClaimsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SetClaimsProvider._internal(
        (ref) => create(ref as SetClaimsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        resource: resource,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _SetClaimsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SetClaimsProvider && other.resource == resource;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, resource.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SetClaimsRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `resource` of this provider.
  String get resource;
}

class _SetClaimsProviderElement extends AutoDisposeFutureProviderElement<bool>
    with SetClaimsRef {
  _SetClaimsProviderElement(super.provider);

  @override
  String get resource => (origin as SetClaimsProvider).resource;
}

String _$resetClaimsHash() => r'1625ef2f60ad0a4c96a07d24e1677bfa43d5ed12';

/// See also [resetClaims].
@ProviderFor(resetClaims)
final resetClaimsProvider = AutoDisposeFutureProvider<bool>.internal(
  resetClaims,
  name: r'resetClaimsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$resetClaimsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ResetClaimsRef = AutoDisposeFutureProviderRef<bool>;
String _$autoSetClaimsHash() => r'5fb0e3baec193c0a4f1b9ea9f980526f5d3ee45f';

/// See also [AutoSetClaims].
@ProviderFor(AutoSetClaims)
final autoSetClaimsProvider =
    AutoDisposeNotifierProvider<AutoSetClaims, bool>.internal(
  AutoSetClaims.new,
  name: r'autoSetClaimsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$autoSetClaimsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AutoSetClaims = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
