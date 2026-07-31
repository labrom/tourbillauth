import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config.g.dart';

@riverpod
String? usersFirestoreDatabaseName(Ref ref) => null;

@riverpod
String usersCollectionName(Ref ref) => 'users';

@riverpod
String rolesFieldName(Ref ref) => 'roles';

final authProviders = <AuthProvider>[
  GoogleProvider(
    // clientId not used on Android and iOS (iOSPreferPlist is true for iOS)
    clientId: '',
    iOSPreferPlist: true,
  ),
];

List<AuthProvider> defaultAuthProviders({
  bool enableEmailPasswordAuth = false,
}) =>
    [if (enableEmailPasswordAuth) EmailAuthProvider(), ...authProviders];
