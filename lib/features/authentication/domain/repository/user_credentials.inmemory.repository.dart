import 'package:flitv_ca/features/authentication/data/repository/user_credentials.repository.dart';
import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';

class InMemoryUserCredentialsRepository implements UserCredentialsRepository {
  @override
  UserCredentials? currentUser;
  late List<UserCredentials> listUserCredentials = List.empty(growable: true);

  @override
  Future<List<UserCredentials>> getAllUsers() {
    return Future(() => listUserCredentials);
  }

  @override
  Future<void> save(UserCredentials user) async {
    try {
      UserCredentials userExist = await getByID(user.id);
      listUserCredentials[listUserCredentials.indexOf(userExist)] = user;
    } catch (error) {
      if (error is UserNotFound) {
        listUserCredentials.add(user);
      }
    }
  }

  @override
  Future<UserCredentials> getByID(String id) {
    UserCredentials userExist = listUserCredentials.firstWhere(
        (element) => element.name == id,
        orElse: () => throw UserNotFound());
    return Future(() => userExist);
  }

  @override
  Future<void> givenExistingUsers(List<UserCredentials> users) {
    return Future(() => listUserCredentials = users);
  }

  @override
  Future<void> selectCurrentUser(UserCredentials user) async {
    currentUser = user;
  }

  @override
  UserCredentials? getCurrentUser() {
    return currentUser;
  }

  @override
  void logoutCurrentUser() {
    currentUser = null;
  }
}
