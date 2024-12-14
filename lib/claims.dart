import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'claims.g.dart';

@riverpod
Future<bool> setClaims(Ref ref, String resource) async {
  final token = await FirebaseAuth.instance.currentUser!.getIdToken();
  final response = await get(
      Uri.parse(
          'https://iam-351431708551.us-west4.run.app/access?res=${Uri.encodeComponent(resource)}'),
      headers: {
        'Authorization': 'Bearer $token',
      });

  if (response.statusCode == HttpStatus.ok) {
    await FirebaseAuth.instance.currentUser!.getIdToken(true);
    return true;
  }
  return false;
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
    final result = ref.watch(setClaimsProvider(resource));
    return result.value == true ? child : zeroState;
  }
}
