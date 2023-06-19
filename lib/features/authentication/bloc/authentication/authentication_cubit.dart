import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';
import 'package:flitv_ca/features/authentication/data/repository/auth.repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown());

  final AuthenticationRepository _authenticationRepository;

  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> initialize() async {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => _onAuthenticationStatusChanged(status),
    );
    await _checkAuthenticationStatus();
  }

  Future<void> _checkAuthenticationStatus() async {
    final status = await _authenticationRepository.status.last;
    _onAuthenticationStatusChanged(status);
  }

  Future<void> _onAuthenticationStatusChanged(
      AuthenticationStatus status) async {
    switch (status) {
      case AuthenticationStatus.unauthenticated:
        emit(const AuthenticationState.unauthenticated());
        break;
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );
        break;
      case AuthenticationStatus.unknown:
        emit(const AuthenticationState.unknown());
        break;
    }
  }

  void logout() {
    _authenticationRepository.logoutUser();
  }

  Future<UserCredentials?> _tryGetUser() async {
    try {
      final user = _authenticationRepository.getCurrentUser();
      return user;
    } catch (_) {
      return null;
    }
  }
}
