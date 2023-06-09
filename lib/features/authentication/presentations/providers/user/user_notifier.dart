import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';
import 'package:flitv_ca/features/authentication/data/repository/user.repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_state.dart';

class UserNotifier extends StateNotifier<UserState> {
  final UserRepository userRepository;

  UserNotifier({
    required this.userRepository,
  }) : super(const UserState.initial());

  Future<void> saveUser(Map<String, String> data) async {
    state = const UserState.loading();
    try {
      await userRepository.save(UserCredentials.fromData(data));
      state = const UserState.success();
    } catch (e) {
      state = UserState.failure(e as Error);
    }
  }
}
