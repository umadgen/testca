import 'package:flitv_ca/features/authentication/data/repository/user.repository.dart';
import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';

class InMemoryUserCredentialsRepository implements UserRepository {
  late List<UserCredentials> listUserCredentials = List.empty(growable: true);

  @override
  Future<List<UserCredentials>> getAllUsers() {
    return Future(() => listUserCredentials);
  }

  @override
  Future<void> save(UserCredentials user) async {
    try {
      UserCredentials? existingUser = await getUser(user.id);
      listUserCredentials[listUserCredentials.indexOf(existingUser)] = user;
    } catch (error) {
      if (error is UserNotFound) {
        listUserCredentials.add(user);
        return;
      }
      rethrow;
    }
  }

  @override
  Future<UserCredentials> getUser(String id) async {
    final List<UserCredentials> allUsers = await getAllUsers();
    return allUsers.firstWhere((element) => element.id == id,
        orElse: () => throw UserNotFound());
  }

  @override
  Future<void> givenExistingUsers(List<UserCredentials> users) {
    return Future(() => listUserCredentials = users);
  }
}
