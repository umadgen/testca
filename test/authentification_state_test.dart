import 'dart:convert';

import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';
import 'package:flitv_ca/features/authentication/data/providers/auth_provider.dart';
import 'package:flitv_ca/features/authentication/data/repository/auth.repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'user_credentials_builder.dart';

class Listener extends Mock {
  void call(AuthRepository? previous, AuthRepository value);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Feature: authentification state', () {
    setUp(() {});
    test('Get users', () async {
      // Créez un container de providers pour les tests
      final container = ProviderContainer();

      // Enregistrez les providers nécessaires dans le container
      container.read(authRepositoryProvider);
      container.read(userListProvider);

      // Obtenez la valeur du provider userListProvider
      final AsyncValue<List<UserCredentials>> userListAsyncValue =
          container.read(userListProvider);

      // Vérifiez que le chargement des utilisateurs a commencé
      expect(userListAsyncValue,
          const AsyncValue<List<UserCredentials>>.loading());

      // Attendez que les utilisateurs soient chargés
      await Future.delayed(Duration(seconds: 5));

      // Vérifiez que les utilisateurs sont chargés avec succès
      expect(
          userListAsyncValue, const AsyncValue<List<UserCredentials>>.data([]));

      // Accédez aux utilisateurs chargés
      final List<UserCredentials> userList = userListAsyncValue.value!;

      // Effectuez les assertions sur la liste d'utilisateurs
      expect(userList, isA<List<UserCredentials>>());
      //expect(userList.isEmpty, isTrue);
    });

    test("Select current User", () async {
      FlutterSecureStorage.setMockInitialValues({
        "users": jsonEncode([UserCredentialsDataBuilder().buildMap()])
      });
      final container = ProviderContainer();
      final listener = Listener();

      container.listen<AuthRepository>(
        authRepositoryProvider,
        listener,
        fireImmediately: true,
      );
      addTearDown(container.dispose);
      expect(
        container.read(authRepositoryProvider.notifier).state.currentUser,
        null,
      );

      // On incrémente le compteur
      container.read(authRepositoryProvider.notifier).state.selectCurrentUser(
          UserCredentialsDataBuilder().buildUserCredentials());
      expect(
        container.read(authRepositoryProvider.notifier).state.currentUser,
        UserCredentialsDataBuilder().buildUserCredentials(),
      );
      // "listener" est appelé à nouveau, avec 1 cette fois
      //verify(listener(0, 1)).called(1);
      //verifyNoMoreInteractions(listener);
    });
  });
}
