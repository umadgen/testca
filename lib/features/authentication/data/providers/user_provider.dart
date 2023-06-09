import 'package:flitv_ca/features/authentication/domain/repository/user.securestorage.repository.dart';
import 'package:flitv_ca/features/authentication/data/repository/user.repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_provider.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    SecureStorageUserRepository();
