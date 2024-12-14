// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claims.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$setClaimsHash() => r'779336a4f6ebd5c77473e979c83e5e32d12d0e45';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
