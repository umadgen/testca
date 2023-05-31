import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';
import 'package:flitv_ca/features/authentication/data/repository/user_credentials.repository.dart';

class LoginCredentialsUseCase {
  late UserCredentialsRepository userRepository;
  LoginCredentialsUseCase({required this.userRepository});

  Future<void> handle(String id) async {
    UserCredentials u = await userRepository.getByID(id);
    await userRepository.selectCurrentUser(u);
    return;
  }
}
