import 'package:flitv_ca/features/authentication/domain/repository/user.securestorage.repository.dart';
import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';
import 'package:flitv_ca/features/authentication/domain/usecases/add_credentials.usecase.dart';
import 'package:flitv_ca/features/authentication/domain/usecases/edit_credentials.usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthentificationFixture {
  Error? error;
  late SecureStorageUserRepository userRepository;
  late AddCredentialsUseCase addCredentialsUseCase;
  late EditCredentialsUseCase editCredentialsUseCase;

  AuthentificationFixture() {
    userRepository = SecureStorageUserRepository();
    editCredentialsUseCase =
        EditCredentialsUseCase(userRepository: userRepository);

    addCredentialsUseCase =
        AddCredentialsUseCase(userRepository: userRepository);
  }

  Future<void> whenUserAddCredentials(Map<String, String> uc) async {
    try {
      await addCredentialsUseCase.handle(uc);
    } catch (e) {
      error = e as Error;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> whenUserEditCredentials(Map<String, String> uc) async {
    try {
      await editCredentialsUseCase.handle(uc);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      error = e as Error;
    }
  }

  Future<void> givenExistingUsers(List<UserCredentials> l) async {
    await userRepository.givenExistingUsers(l);
  }

  void thenErrorShouldBe<T extends Error>(T e) {
    expect(error, isA<Error>());
  }

  Future<void> thenUserCredentialsShouldBe(List<UserCredentials> lu) async {
    var l = await userRepository.getAllUsers();
    assert(listEquals(l, lu));
  }
}
