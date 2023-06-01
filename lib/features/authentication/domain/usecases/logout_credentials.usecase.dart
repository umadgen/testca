import 'package:flitv_ca/features/authentication/data/repository/auth.repository.dart';

class LogoutCredentialsUseCase {
  late AuthRepository userRepository;
  LogoutCredentialsUseCase({required this.userRepository});

  Future<void> handle() async {
    userRepository.logoutCurrentUser();
    return;
  }
}
