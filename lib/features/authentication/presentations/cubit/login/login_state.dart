part of 'login_cubit.dart';

final class LoginState extends Equatable {
  final List<UserCredentials> users;
  const LoginState({
    this.users = const [],
  });

  LoginState copyWith({
    List<UserCredentials>? u,
  }) {
    return LoginState(
      users: u ?? users,
    );
  }

  @override
  List<Object> get props => [users];
}
