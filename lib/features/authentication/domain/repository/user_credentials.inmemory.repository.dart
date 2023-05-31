import 'package:flitv_ca/features/authentication/domain/repository/user_credentials.repository.dart';
import 'package:flitv_ca/features/authentication/domain/user_credentials.dart';

class InMemoryUserCredentialsRepository implements UserCredentialsRepository {
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
        (element) => element.id == id,
        orElse: () => throw UserNotFound());
    return Future(() => userExist);
  }
}
