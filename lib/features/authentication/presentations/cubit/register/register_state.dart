part of "register_cubit.dart";

class RegisterState extends Equatable {
  final FormGroup formState;

  const RegisterState({
    required this.formState,
  });

  @override
  List<Object?> get props => [
        formState.errors,
        formState.value,
        formState.validators,
        formState.status
      ];
}
