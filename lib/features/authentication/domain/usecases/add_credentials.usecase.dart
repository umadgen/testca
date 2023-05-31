import 'package:flitv_ca/features/authentication/data/repository/user_credentials.repository.dart';
import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';

class AddCredentialsUserCommand {
  late String username;
  late String password;
  late String baseUrl;
}

class AddCredentialsUseCase {
  late UserCredentialsRepository userRepository;
  AddCredentialsUseCase({required this.userRepository});

  Future<void> handle(Map<String, String> data) async {
    UserCredentials newUser = UserCredentials.fromData(data);
    await userRepository.save(newUser);
    return;
  }
}
