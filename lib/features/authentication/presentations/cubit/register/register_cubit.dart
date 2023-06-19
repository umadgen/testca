import 'package:equatable/equatable.dart';
import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';
import 'package:flitv_ca/features/authentication/data/repository/user.repository.dart';
import 'package:flitv_ca/shared/validators/uri_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

part "register_state.dart";

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(RegisterState(formState: FormGroup({})));

  final UserRepository _userRepository;

  void initializeForm() {
    emit(RegisterState(
        formState: FormGroup({
      'username': FormControl<String>(validators: [
        Validators.required,
        Validators.maxLength(128),
        Validators.minLength(5)
      ]),
      'password': FormControl<String>(validators: [
        Validators.required,
        Validators.maxLength(128),
        Validators.minLength(5)
      ]),
      'name': FormControl<String>(validators: [
        Validators.required,
        Validators.maxLength(128),
        Validators.minLength(5)
      ]),
      'url': FormControl<String>(validators: [
        Validators.required,
        const UriValidator(),
        Validators.maxLength(255),
        Validators.minLength(5)
      ]),
    })));
  }

  Future<void> submit() async {
    if (state.formState.valid) {
      Map<String, String> data = {
        "username": state.formState.controls["username"]!.value as String,
        "password": state.formState.controls["password"]!.value as String,
        "name": state.formState.controls["name"]!.value as String,
        "baseUrl": state.formState.controls["url"]!.value as String
      };
      _userRepository.save(UserCredentials.fromData(data));
    } else {
      state.formState.markAllAsTouched();
      emit(state);
    }
  }

  void updateFormField(String fieldName, dynamic value) {
    final form = state;
    form.formState.control(fieldName).value = value;
    emit(form);
  }
}
