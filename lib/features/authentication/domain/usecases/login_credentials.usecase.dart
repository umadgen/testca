import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';
import 'package:flitv_ca/features/authentication/data/repository/auth.repository.dart';

class LoginCredentialsUseCase {
  late AuthRepository userRepository;
  LoginCredentialsUseCase({required this.userRepository});

  Future<void> handle(String id) async {
    UserCredentials u = await userRepository.getByID(id);
    await userRepository.selectCurrentUser(u);
    return;
  }
}
