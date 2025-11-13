// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

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
    r'6bca4322708f527c2abd13fb07a25f98cd6d867f';

@ProviderFor(firebaseAuth)
const firebaseAuthProvider = FirebaseAuthProvider._();

final class FirebaseAuthProvider
    extends $FunctionalProvider<FirebaseAuth, FirebaseAuth, FirebaseAuth>
    with $Provider<FirebaseAuth> {
  const FirebaseAuthProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'firebaseAuthProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firebaseAuthHash();

  @$internal
  @override
  $ProviderElement<FirebaseAuth> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseAuth create(Ref ref) {
    return firebaseAuth(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseAuth value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseAuth>(value),
    );
  }
}

String _$firebaseAuthHash() => r'8f9dd590959e35932285fca37913676bd13a02fd';

@ProviderFor(authStateChanges)
const authStateChangesProvider = AuthStateChangesProvider._();

final class AuthStateChangesProvider
    extends $FunctionalProvider<AsyncValue<User?>, User?, Stream<User?>>
    with $FutureModifier<User?>, $StreamProvider<User?> {
  const AuthStateChangesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authStateChangesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authStateChangesHash();

  @$internal
  @override
  $StreamProviderElement<User?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<User?> create(Ref ref) {
    return authStateChanges(ref);
  }
}

String _$authStateChangesHash() => r'ed73bb63cae92e791c80e19c01a8eb421d09a663';

@ProviderFor(authStateChangesStream)
const authStateChangesStreamProvider = AuthStateChangesStreamProvider._();

final class AuthStateChangesStreamProvider extends $FunctionalProvider<
    Raw<Stream<User?>>,
    Raw<Stream<User?>>,
    Raw<Stream<User?>>> with $Provider<Raw<Stream<User?>>> {
  const AuthStateChangesStreamProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authStateChangesStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authStateChangesStreamHash();

  @$internal
  @override
  $ProviderElement<Raw<Stream<User?>>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Raw<Stream<User?>> create(Ref ref) {
    return authStateChangesStream(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Raw<Stream<User?>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Raw<Stream<User?>>>(value),
    );
  }
}

String _$authStateChangesStreamHash() =>
    r'c0c467ed5d1134c3fc143ab915ea641e8ae30e17';

@ProviderFor(idTokenChanges)
const idTokenChangesProvider = IdTokenChangesProvider._();

final class IdTokenChangesProvider
    extends $FunctionalProvider<AsyncValue<User?>, User?, Stream<User?>>
    with $FutureModifier<User?>, $StreamProvider<User?> {
  const IdTokenChangesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'idTokenChangesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$idTokenChangesHash();

  @$internal
  @override
  $StreamProviderElement<User?> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<User?> create(Ref ref) {
    return idTokenChanges(ref);
  }
}

String _$idTokenChangesHash() => r'a4c27f4409b61d3a4c05ef168634d042bbeb20e1';

@ProviderFor(user)
const userProvider = UserProvider._();

final class UserProvider extends $FunctionalProvider<User?, User?, User?>
    with $Provider<User?> {
  const UserProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userHash();

  @$internal
  @override
  $ProviderElement<User?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  User? create(Ref ref) {
    return user(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(User? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<User?>(value),
    );
  }
}

String _$userHash() => r'd5a5fa8e9a2f0a8abf75ec979c1f15e7ad52780c';

@ProviderFor(userId)
const userIdProvider = UserIdProvider._();

final class UserIdProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  const UserIdProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userIdProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userIdHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return userId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$userIdHash() => r'db1cd44c22255f47c715fb0f20d437e42db6f179';

@ProviderFor(appUser)
const appUserProvider = AppUserProvider._();

final class AppUserProvider extends $FunctionalProvider<AsyncValue<AppUser?>,
        AppUser?, FutureOr<AppUser?>>
    with $FutureModifier<AppUser?>, $FutureProvider<AppUser?> {
  const AppUserProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appUserProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appUserHash();

  @$internal
  @override
  $FutureProviderElement<AppUser?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AppUser?> create(Ref ref) {
    return appUser(ref);
  }
}

String _$appUserHash() => r'e2d1357f285ee80f07d95f3a424183611fd69a17';
