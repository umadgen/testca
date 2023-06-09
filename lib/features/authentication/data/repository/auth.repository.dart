import '../models/user_credentials.dart';

abstract class AuthenticationRepository {
  UserCredentials? currentUser;

  Future<void> loginUser({required UserCredentials user});
  Future<void> logoutUser();
}
