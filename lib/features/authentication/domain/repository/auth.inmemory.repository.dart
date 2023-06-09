import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';
import 'package:flitv_ca/features/authentication/data/repository/auth.repository.dart';

class InMemoryAuth implements AuthenticationRepository {
  @override
  UserCredentials? currentUser;

  @override
  Future<void> loginUser({required UserCredentials user}) async {
    currentUser = user;
  }

  @override
  Future<void> logoutUser() async {
    currentUser = null;
  }
}
