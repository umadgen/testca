import '../user_credentials.dart';

abstract class UserCredentialsRepository {
  Future<void> save(UserCredentials user);

  Future<List<UserCredentials>> getAllUsers();
  Future<UserCredentials> getByID(String id);
}

class UserNotFound extends Error {}
