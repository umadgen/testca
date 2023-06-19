import 'package:equatable/equatable.dart';
import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';
import 'package:flitv_ca/features/authentication/data/repository/auth.repository.dart';
import 'package:flitv_ca/features/authentication/data/repository/user.repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;

  void updateUsers() async {
    List<UserCredentials> users = await _userRepository.getAllUsers();
    emit(LoginState(users: users));
  }

  void submit(String id) async {
    UserCredentials u = await _userRepository.getUser(id);
    _authenticationRepository.loginUser(user: u);
  }
}
