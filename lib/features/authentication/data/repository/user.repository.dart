import '../models/user_credentials.dart';

abstract class UserRepository {
  Future<void> save(UserCredentials user);

  Future<List<UserCredentials>> getAllUsers();
  Future<UserCredentials> getUser(String id);

  Future<void> givenExistingUsers(List<UserCredentials> users);
}

class UserNotFound extends Error {}
