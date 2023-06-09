import 'package:flitv_ca/features/authentication/data/repository/auth.repository.dart';
import 'package:flitv_ca/features/authentication/data/repository/user.repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_state.dart';
part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  final UserRepository _userRepository;
  final AuthenticationRepository _authRepository;

  AuthNotifier(
    this._userRepository,
    this._authRepository,
  ) : super();

  Future<void> loginUser(String id) async {
    state = const AuthState.loading();
    try {
      final user = await _userRepository.getUser(id);
      await _authRepository.loginUser(user: user);
      state = const AuthState.connected();
    } catch (e) {
      state = AuthState.failure(e as Error);
    }
  }

  Future<void> logoutUser() async {
    state = const AuthState.loading();
    try {
      await _authRepository.logoutUser();
      state = const AuthState.connected();
    } catch (e) {
      state = AuthState.failure(e as Error);
    }
  }

  @override
  AuthState build() {
    return const AuthState.initial();
  }
}
