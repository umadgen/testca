import 'dart:async';

import '../models/user_credentials.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthenticationRepository {
  UserCredentials? currentUser;
  StreamController<AuthenticationStatus> controller =
      StreamController<AuthenticationStatus>();
  Stream<AuthenticationStatus> get status;
  Future<void> logoutUser();
  Future<void> loginUser({required UserCredentials user});
  UserCredentials? getCurrentUser();
}
