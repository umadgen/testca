import 'package:bloc_test/bloc_test.dart';
import 'package:flitv_ca/features/authentication/data/repository/user.repository.dart';
import 'package:flitv_ca/features/authentication/presentations/cubit/register/register_cubit.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'UserCredentials/user_credentials_builder.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository u;
  late RegisterCubit r;
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    u = MockUserRepository();
    r = RegisterCubit(userRepository: u);
    when(() => u.save(UserCredentialsDataBuilder().buildUserCredentials()))
        .thenAnswer((_) async => null);
  });

  group('Register cubit', () {
    blocTest<RegisterCubit, RegisterState>("init register form",
        //setUp: () => when(() => r.initializeForm()),
        build: () => r,
        act: (cubit) {
          cubit.initializeForm();
        },
        expect: () => [
              isA<RegisterState>()
                  .having((w) => w.formState.valid, 'is not valid', false)
                  .having((w) => w.formState.hasErrors, 'is in error', true)
                  .having((w) => w.formState.errors.length, 'has 4  errors', 4),
            ]);

    blocTest<RegisterCubit, RegisterState>("update username with invalid value",
        //setUp: () => when(() => r.initializeForm()),
        build: () => r,
        act: (cubit) {
          cubit.initializeForm();
          cubit.updateFormField("username", "");
        },
        expect: () => [
              isA<RegisterState>()
                  .having((w) => w.formState.valid, 'is not valid', false)
                  .having((w) => w.formState.hasErrors, 'is in error', true)
                  .having((w) => w.formState.errors.length, 'has 4  errors', 4),
            ]);

    blocTest<RegisterCubit, RegisterState>("update form with invalid value",
        //setUp: () => when(() => r.initializeForm()),
        build: () => r,
        act: (cubit) {
          cubit.initializeForm();
          cubit.updateFormField("username", "");
          cubit.updateFormField("password", "");
          cubit.updateFormField("name", "");
          cubit.updateFormField("url", "");
        },
        expect: () => [
              isA<RegisterState>()
                  .having(
                      (w) => w.formState.valid, 'validators not empty', false)
                  .having((w) => w.formState.hasErrors, 'validators not empty',
                      true)
                  .having((w) => w.formState.errors.length,
                      'validators not empty', 4),
            ]);

    blocTest<RegisterCubit, RegisterState>(
      "update form with valid value",
      //setUp: () => when(() => r.initializeForm()),
      build: () => r,
      act: (cubit) {
        cubit.initializeForm();
        cubit.updateFormField("username", "testest");
        cubit.updateFormField("password", "testest");
        cubit.updateFormField("name", "testest");
        cubit.updateFormField("url", "http://www.google.fr");
      },
      expect: () => [
        isA<RegisterState>()
            .having((w) => w.formState.valid, 'form is valid', true)
            .having((w) => w.formState.hasErrors, 'form has no errors', false)
      ],
      verify: (_) {
        verifyNever(
            () => u.save(UserCredentialsDataBuilder().buildUserCredentials()));
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      "test submit register form",
      build: () => r,
      act: (cubit) {
        cubit.initializeForm();
        cubit.updateFormField("username",
            UserCredentialsDataBuilder().buildUserCredentials().getUsername);
        cubit.updateFormField("password",
            UserCredentialsDataBuilder().buildUserCredentials().getPassword);
        cubit.updateFormField("name",
            UserCredentialsDataBuilder().buildUserCredentials().getName);
        cubit.updateFormField(
            "url",
            UserCredentialsDataBuilder()
                .buildUserCredentials()
                .getBaseUrl
                .toString());
        cubit.submit();
      },
      expect: () => <dynamic>[
        isA<RegisterState>()
            .having((w) => w.formState.valid, 'validators not empty', true)
            .having(
                (w) => w.formState.hasErrors, 'validators not empty', false),
      ],
      verify: (_) {
        verify(() =>
                u.save(UserCredentialsDataBuilder().buildUserCredentials()))
            .called(1);
      },
    );
  });
}
