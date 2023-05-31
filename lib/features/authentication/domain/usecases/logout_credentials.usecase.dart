import 'package:flitv_ca/features/authentication/data/repository/user_credentials.repository.dart';

class LogoutCredentialsUseCase {
  late UserCredentialsRepository userRepository;
  LogoutCredentialsUseCase({required this.userRepository});

  Future<void> handle() async {
    userRepository.logoutCurrentUser();
    return;
  }
}
