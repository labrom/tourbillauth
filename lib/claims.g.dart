// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claims.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AutoSetClaims)
const autoSetClaimsProvider = AutoSetClaimsProvider._();

final class AutoSetClaimsProvider
    extends $NotifierProvider<AutoSetClaims, bool> {
  const AutoSetClaimsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'autoSetClaimsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$autoSetClaimsHash();

  @$internal
  @override
  AutoSetClaims create() => AutoSetClaims();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$autoSetClaimsHash() => r'5fb0e3baec193c0a4f1b9ea9f980526f5d3ee45f';

abstract class _$AutoSetClaims extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(setClaims)
const setClaimsProvider = SetClaimsFamily._();

final class SetClaimsProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const SetClaimsProvider._(
      {required SetClaimsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'setClaimsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$setClaimsHash();

  @override
  String toString() {
    return r'setClaimsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as String;
    return setClaims(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SetClaimsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$setClaimsHash() => r'e400a82f24a531e60b7bf1cf7f17c440dd19c9e8';

final class SetClaimsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, String> {
  const SetClaimsFamily._()
      : super(
          retry: null,
          name: r'setClaimsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  SetClaimsProvider call(
    String resource,
  ) =>
      SetClaimsProvider._(argument: resource, from: this);

  @override
  String toString() => r'setClaimsProvider';
}

@ProviderFor(resetClaims)
const resetClaimsProvider = ResetClaimsProvider._();

final class ResetClaimsProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  const ResetClaimsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'resetClaimsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$resetClaimsHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return resetClaims(ref);
  }
}

String _$resetClaimsHash() => r'1625ef2f60ad0a4c96a07d24e1677bfa43d5ed12';
