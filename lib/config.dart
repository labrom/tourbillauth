import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config.g.dart';

@riverpod
String? usersFirestoreDatabaseName(_) => null;

@riverpod
String usersCollectionName(_) => 'users';

@riverpod
String rolesFieldName(_) => 'roles';

final authProviders = <AuthProvider>[
  // EmailAuthProvider(),
  GoogleProvider(
    // clientId not used on Android and iOS (iOSPreferPlist is true for iOS)
    clientId: '',
    iOSPreferPlist: true,
  ),
];
