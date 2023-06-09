import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';
import 'package:flitv_ca/features/authentication/data/providers/user_provider.dart';
import 'package:flitv_ca/features/authentication/data/repository/user.repository.dart';
import 'package:flitv_ca/features/authentication/presentations/providers/user/user_notifier.dart';
import 'package:flitv_ca/features/authentication/presentations/providers/user/user_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStateNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState>(
  (ref) {
    final UserRepository userRepository = ref.watch(userRepositoryProvider);
    return UserNotifier(
      userRepository: userRepository,
    );
  },
);

final allUsersStateProvider = FutureProvider<List<UserCredentials>>(
  (ref) {
    final UserRepository userRepository = ref.watch(userRepositoryProvider);
    return userRepository.getAllUsers();
  },
);
