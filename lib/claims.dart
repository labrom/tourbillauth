import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tourbillauth/auth.dart';

part 'claims.g.dart';

@riverpod
class AutoSetClaims extends _$AutoSetClaims {
  @override
  bool build() => true;
  void toggle() {
    state = !state;
  }
}

@riverpod
Future<bool> setClaims(Ref ref, String resource) async {
  if (!ref.watch(autoSetClaimsProvider)) {
    return false;
  }
  final user = ref.watch(userProvider);
  if (user == null) {
    return false;
  }
  final token = await user.getIdToken();
  final response = await get(
      Uri.parse(
          'https://iam-351431708551.us-west4.run.app/access?res=${Uri.encodeComponent(resource)}'),
      headers: {
        'Authorization': 'Bearer $token',
      });

  if (response.statusCode == HttpStatus.ok) {
    await user.getIdToken(true);
    return true;
  }
  return false;
}

@riverpod
Future<bool> resetClaims(Ref ref) async {
  final user = ref.watch(userProvider);
  if (user == null) {
    return false;
  }
  final token = await user.getIdToken();
  final response = await get(
      Uri.parse('https://iam-351431708551.us-west4.run.app/reset'),
      headers: {
        'Authorization': 'Bearer $token',
      });

  return response.statusCode == HttpStatus.ok;
}

class ClaimSetting extends ConsumerWidget {
  const ClaimSetting({
    super.key,
    required this.resource,
    required this.zeroState,
    required this.child,
  });

  final Widget child;
  final Widget zeroState;
  final String resource;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(idTokenChangesProvider);
    final result = ref.watch(setClaimsProvider(resource));
    return result.value == true ? child : zeroState;
  }
}
