import 'package:flitv_ca/features/authentication/domain/repository/user_credentials.repository.dart';
import 'package:flitv_ca/features/authentication/domain/user_credentials.dart';

class EditCredentialsUserCommand {
  late String id;
  late String username;
  late String password;
  late String baseUrl;
}

class EditCredentialsUseCase {
  late UserCredentialsRepository userRepository;
  EditCredentialsUseCase({required this.userRepository});

  Future<void> handle(Map<String, String> command) async {
    UserCredentials newUser = await userRepository.getByID(command['id']!);

    await userRepository.save(newUser.copyWith(
        bu: command['baseUrl']!,
        p: command['password']!,
        u: command['username']!));
    return Future(() => null);
  }
}
