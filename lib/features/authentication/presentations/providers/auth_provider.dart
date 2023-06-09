import 'package:flitv_ca/features/authentication/data/providers/auth_provider.dart';
import 'package:flitv_ca/features/authentication/data/providers/user_provider.dart';
import 'package:flitv_ca/features/authentication/presentations/providers/auth/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'auth/auth_notifier.dart';
part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
AuthNotifier authStateNotifier(AuthStateNotifierRef ref) {
  return AuthNotifier(
      ref.watch(userRepositoryProvider), ref.watch(authRepositoryProvider));
}
