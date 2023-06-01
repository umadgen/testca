import 'package:flitv_ca/features/authentication/data/repository/auth.repository.dart';
import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';

class EditCredentialsUseCase {
  late AuthRepository userRepository;
  EditCredentialsUseCase({required this.userRepository});

  Future<void> handle(Map<String, String> command) async {
    UserCredentials newUser = await userRepository.getByID(command['id']!);

    await userRepository.save(newUser.copyWith(
        n: command["name"],
        bu: command['baseUrl']!,
        p: command['password']!,
        u: command['username']!));
    return Future(() => null);
  }
}
