import '../models/user_credentials.dart';

abstract class AuthRepository {
  UserCredentials? currentUser;
  Future<void> save(UserCredentials user);

  Future<List<UserCredentials>> getAllUsers();
  Future<UserCredentials> getByID(String id);
  UserCredentials? getCurrentUser();

  Future<void> givenExistingUsers(List<UserCredentials> users);

  Future<void> selectCurrentUser(UserCredentials id);
  void logoutCurrentUser();
}

class UserNotFound extends Error {}
