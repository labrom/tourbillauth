// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(usersFirestoreDatabaseName)
const usersFirestoreDatabaseNameProvider =
    UsersFirestoreDatabaseNameProvider._();

final class UsersFirestoreDatabaseNameProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  const UsersFirestoreDatabaseNameProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'usersFirestoreDatabaseNameProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$usersFirestoreDatabaseNameHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return usersFirestoreDatabaseName(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$usersFirestoreDatabaseNameHash() =>
    r'8a2ed00b632cb4161f1794c88777d4c5764afcf8';

@ProviderFor(usersCollectionName)
const usersCollectionNameProvider = UsersCollectionNameProvider._();

final class UsersCollectionNameProvider
    extends $FunctionalProvider<String, String, String> with $Provider<String> {
  const UsersCollectionNameProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'usersCollectionNameProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$usersCollectionNameHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return usersCollectionName(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$usersCollectionNameHash() =>
    r'3516ca416b02764e8ecacdb85d8ff4a35dd15451';

@ProviderFor(rolesFieldName)
const rolesFieldNameProvider = RolesFieldNameProvider._();

final class RolesFieldNameProvider
    extends $FunctionalProvider<String, String, String> with $Provider<String> {
  const RolesFieldNameProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'rolesFieldNameProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$rolesFieldNameHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return rolesFieldName(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$rolesFieldNameHash() => r'7164805918d76325193406294b91a051403fab15';
