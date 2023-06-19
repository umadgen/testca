import 'package:bloc_test/bloc_test.dart';
import 'package:flitv_ca/features/authentication/data/repository/auth.repository.dart';
import 'package:flitv_ca/features/authentication/data/repository/user.repository.dart';
import 'package:flitv_ca/features/authentication/presentations/cubit/login/login_cubit.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'UserCredentials/user_credentials_builder.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockAuthenticationRepository a;
  late MockUserRepository u;
  late LoginCubit l;
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    a = MockAuthenticationRepository();
    u = MockUserRepository();
    l = LoginCubit(authenticationRepository: a, userRepository: u);
    when(() => u.getAllUsers()).thenAnswer(
        (_) async => [UserCredentialsDataBuilder().buildUserCredentials()]);

    when(() => u.getUser("52")).thenAnswer(
        (_) async => UserCredentialsDataBuilder().buildUserCredentials());

    when(() => u.save(UserCredentialsDataBuilder().buildUserCredentials()))
        .thenAnswer((_) async => null);

    when(() => a.loginUser(
            user: UserCredentialsDataBuilder().buildUserCredentials()))
        .thenAnswer((_) async => null);
  });

  group('Login cubit', () {
    blocTest<LoginCubit, LoginState>("init login cubit",
        //setUp: () => when(() => r.initializeForm()),
        build: () => l,
        act: (cubit) {
          cubit.updateUsers();
        },
        expect: () => [
              isA<LoginState>().having((w) => w.users, 'has one user',
                  [UserCredentialsDataBuilder().buildUserCredentials()])
            ]);

    blocTest<LoginCubit, LoginState>(
      "login user",
      build: () => l,
      act: (cubit) {
        cubit.updateUsers();
        cubit.submit("52");
      },
      expect: () => [
        isA<LoginState>().having((w) => w.users, 'has one user',
            [UserCredentialsDataBuilder().buildUserCredentials()])
      ],
      verify: (_) {
        verify(() => u.getUser("52")).called(1);
        verify(() => a.loginUser(
                user: UserCredentialsDataBuilder().buildUserCredentials()))
            .called(1);
      },
    );
  });
}
