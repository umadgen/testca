part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState._();

  const factory AuthenticationState.unknown() = UnknownState;
  const factory AuthenticationState.authenticated(UserCredentials user) =
      AuthenticatedState;
  const factory AuthenticationState.unauthenticated() = UnauthenticatedState;
}

class UnknownState extends AuthenticationState {
  const UnknownState() : super._();

  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthenticationState {
  const AuthenticatedState(this.user) : super._();

  final UserCredentials user;

  @override
  List<Object> get props => [user];
}

class UnauthenticatedState extends AuthenticationState {
  const UnauthenticatedState() : super._();

  @override
  List<Object> get props => [];
}
