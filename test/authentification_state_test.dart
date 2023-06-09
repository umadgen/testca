import 'dart:convert';

import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';
import 'package:flitv_ca/features/authentication/presentations/providers/auth/auth_state.dart';
import 'package:flitv_ca/features/authentication/presentations/providers/auth_provider.dart';
import 'package:flitv_ca/features/authentication/presentations/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'UserCredentials/user_credentials_builder.dart';

class Listener extends Mock {
  void call(dynamic previous, dynamic value);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Feature: authentification state', () {
    setUp(() {});

    test("Select current User", () async {
      FlutterSecureStorage.setMockInitialValues({
        "users": jsonEncode([UserCredentialsDataBuilder().buildMap()])
      });
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final listener = Listener();

      container.listen<AuthState?>(
        authStateNotifierProvider,
        listener.call,
        fireImmediately: true,
      );
      verify(listener(null, const AuthState.initial())).called(1);
      //verifyNoMoreInteractions(listener);

      container
          .read(authStateNotifierProvider.notifier)
          .loginUser(UserCredentialsDataBuilder().buildUserCredentials().id);

      verify(listener(const AuthState.initial(), const AuthState.loading()))
          .called(1);

      verify(listener(
              null, UserCredentialsDataBuilder().buildUserCredentials()))
          .called(1);

      verifyNoMoreInteractions(listener);
    });
  });
}
