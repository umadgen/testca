import 'dart:async';

import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';
import 'package:flitv_ca/features/authentication/data/repository/auth.repository.dart';

class InMemoryAuth implements AuthenticationRepository {
  InMemoryAuth() {
    controller = StreamController<AuthenticationStatus>();
  }
  @override
  StreamController<AuthenticationStatus> controller =
      StreamController<AuthenticationStatus>();

  @override
  UserCredentials? currentUser;

  @override
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* controller.stream;
  }

  @override
  Future<void> loginUser({required UserCredentials user}) async {
    currentUser = user;
  }

  @override
  Future<void> logoutUser() async {
    currentUser = null;
  }

  @override
  UserCredentials? getCurrentUser() {
    return currentUser;
  }
}
