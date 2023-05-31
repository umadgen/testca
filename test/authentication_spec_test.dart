import 'package:flitv_ca/features/authentication/domain/repository/user_credentials.securestorage.repository.dart';
import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';
import 'package:flitv_ca/features/authentication/domain/usecases/add_credentials.usecase.dart';
import 'package:flitv_ca/features/authentication/domain/usecases/edit_credentials.usecase.dart';
import 'package:flitv_ca/features/authentication/domain/usecases/login_credentials.usecase.dart';
import 'package:flitv_ca/features/authentication/domain/usecases/logout_credentials.usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'user_credentials_builder.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Feature: authentification', () {
    late AuthentificationFixture fixture;
    late UserCredentialsDataBuilder builder;
    setUp(() {
      FlutterSecureStorage.setMockInitialValues({});
      fixture = AuthentificationFixture();
      builder = UserCredentialsDataBuilder();
    });
    group('Username', () {
      test("Alice add a username of 279 characters", () async {
        await fixture.whenUserAddCredentials(
            builder.withUsername("newUsername").buildMap());
        await fixture.thenUserCredentialsShouldBe(List.filled(
            1, builder.withUsername("newUsername").buildUserCredentials()));
      });
      test("Alice update her username", () async {
        await fixture.whenUserAddCredentials(
            builder.withUsername("newUsername").buildMap());
        await fixture.thenUserCredentialsShouldBe(List.filled(
            1, builder.withUsername("newUsername").buildUserCredentials()));
        await fixture.whenUserAddCredentials(
            builder.withUsername("NotMyUsername").buildMap());
        await fixture.thenUserCredentialsShouldBe(List.filled(
            1, builder.withUsername("NotMyUsername").buildUserCredentials()));
      });
      group('Rule: A username can have a length of 280 characters maximum', () {
        test("Alice add a username of 281 characters", () async {
          const textWith281characters =
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras mauris lacus, fringilla eu est vitae, varius viverra nisl. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vivamus suscipit feugiat sollicitudin. Aliquam erat volutpat amet.";

          await fixture.whenUserAddCredentials(
              builder.withUsername(textWith281characters).buildMap());
          fixture.thenErrorShouldBe(UsernameTooLongError());
          await fixture.thenUserCredentialsShouldBe(List.empty());
        });
      });

      group('Rule: A username can\'t be empty', () {
        test("Alice add a empty username", () async {
          await fixture
              .whenUserAddCredentials(builder.withUsername("").buildMap());
          fixture.thenErrorShouldBe(EmptyUsernameError());
          await fixture.thenUserCredentialsShouldBe(List.empty());
        });

        test("Alice add a  username with space", () async {
          await fixture.whenUserAddCredentials(
              builder.withUsername("        ").buildMap());
          fixture.thenErrorShouldBe(EmptyUsernameError());
          await fixture.thenUserCredentialsShouldBe(List.empty());
        });
      });
    });

    group('Password', () {
      test("Alice add a password of 128 characters", () async {
        const newPassword =
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus metus metus, semper et aliquam id, malesuada et neque volutpat.";
        await fixture.whenUserAddCredentials(
            builder.withPassword(newPassword).buildMap());
        await fixture.thenUserCredentialsShouldBe(List.filled(
            1, builder.withPassword(newPassword).buildUserCredentials()));
      });

      test("Alice update her password", () async {
        await fixture.whenUserAddCredentials(
            builder.withPassword("newPassword").buildMap());
        await fixture.thenUserCredentialsShouldBe(List.filled(
            1, builder.withPassword("newPassword").buildUserCredentials()));
        await fixture.whenUserAddCredentials(
            builder.withPassword("NEWWWPassword").buildMap());
        await fixture.thenUserCredentialsShouldBe(List.filled(
            1, builder.withPassword("NEWWWPassword").buildUserCredentials()));
      });
      group('Rule: A password can have a length of 128 characters maximum', () {
        test("Alice add a password of 129 characters", () async {
          const passwordWith129characters =
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus metus metus, semper et aliquam id, malesuada et neque volutpat..";

          await fixture.whenUserAddCredentials(
              builder.withPassword(passwordWith129characters).buildMap());
          fixture.thenErrorShouldBe(PasswordTooLongError());
          await fixture.thenUserCredentialsShouldBe(List.empty());
        });
      });

      group('Rule: A password can\'t be empty', () {
        test("Alice add a empty password", () async {
          await fixture
              .whenUserAddCredentials(builder.withPassword("").buildMap());
          fixture.thenErrorShouldBe(EmptyPasswordError());
          await fixture.thenUserCredentialsShouldBe(List.empty());
        });

        test("Alice add a password with space", () async {
          await fixture.whenUserAddCredentials(
              builder.withPassword("        ").buildMap());
          fixture.thenErrorShouldBe(EmptyPasswordError());
          await fixture.thenUserCredentialsShouldBe(List.empty());
        });
      });
    });

    group('Base url', () {
      test("Alice add a url of 128 characters", () async {
        const newUrl =
            "https://www.googlegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegoogl.fr";
        await fixture
            .whenUserAddCredentials(builder.withBaseUrl(newUrl).buildMap());
        await fixture.thenUserCredentialsShouldBe(
            List.filled(1, builder.withBaseUrl(newUrl).buildUserCredentials()));
      });

      test("Alice update her baseUrl", () async {
        await fixture.whenUserAddCredentials(
            builder.withBaseUrl("http://www.google.fr").buildMap());
        await fixture.thenUserCredentialsShouldBe(List.filled(
            1,
            builder
                .withBaseUrl("http://www.google.fr")
                .buildUserCredentials()));
        await fixture.whenUserAddCredentials(
            builder.withBaseUrl("http://www.bing.fr").buildMap());
        await fixture.thenUserCredentialsShouldBe(List.filled(1,
            builder.withBaseUrl("http://www.bing.fr").buildUserCredentials()));
      });
      group('Rule: A url can have a length of 128 characters maximum', () {
        test("Alice add an url of 129 characters", () async {
          const urlWith129characters =
              "https://www.googlegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegoogle.fr";

          await fixture.whenUserAddCredentials(
              builder.withBaseUrl(urlWith129characters).buildMap());
          fixture.thenErrorShouldBe(UrlTooLongError());
          await fixture.thenUserCredentialsShouldBe(List.empty());
        });
      });

      group('Rule: A url must be formatted as a url', () {
        test("Alice add a bad formatted url", () async {
          const urlWith129characters = "xd.lol";

          await fixture.whenUserAddCredentials(
              builder.withBaseUrl(urlWith129characters).buildMap());
          fixture.thenErrorShouldBe(UrlBadFormat());
          await fixture.thenUserCredentialsShouldBe(List.empty());
        });
      });

      group('Rule: An url can\'t be empty', () {
        test("Alice add an url password", () async {
          await fixture
              .whenUserAddCredentials(builder.withBaseUrl("").buildMap());
          fixture.thenErrorShouldBe(EmptyUrlError());
          await fixture.thenUserCredentialsShouldBe(List.empty());
        });

        test("Alice add an url with space", () async {
          await fixture.whenUserAddCredentials(
              builder.withBaseUrl("        ").buildMap());
          fixture.thenErrorShouldBe(EmptyUrlError());
          await fixture.thenUserCredentialsShouldBe(List.empty());
        });
      });
    });

    group('Name', () {
      test("Alice add a name of 128 characters", () async {
        await fixture
            .whenUserAddCredentials(builder.withName("myname").buildMap());
        await fixture.thenUserCredentialsShouldBe(
            List.filled(1, builder.withName("myname").buildUserCredentials()));
      });

      test("Alice update her name", () async {
        await fixture.givenExistingUsers(
            [builder.withName("BadName").withId("1").buildUserCredentials()]);
        await fixture.whenUserEditCredentials(
            builder.withName("GoodName").withId("1").buildMap());
        await fixture.thenUserCredentialsShouldBe(List.filled(1,
            builder.withName("GoodName").withId("1").buildUserCredentials()));
      });
      group(
          'Rule: A name can have a length of 128 characters maximum and must be not empty',
          () {
        test("Alice add a name of 129 characters", () async {
          const nameWith129characters =
              "googlegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegoo";

          await fixture.whenUserAddCredentials(
              builder.withName(nameWith129characters).buildMap());
          fixture.thenErrorShouldBe(NameTooLongError());
          await fixture.thenUserCredentialsShouldBe(List.empty());
        });

        test("Alice update with a name of 129 characters ", () async {
          const nameWith129characters =
              "googlegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegooglegoo";
          await fixture.givenExistingUsers(
              [builder.withName("BadName").withId("1").buildUserCredentials()]);
          await fixture.whenUserEditCredentials(
              builder.withName(nameWith129characters).withId("1").buildMap());

          fixture.thenErrorShouldBe(NameTooLongError());
          await fixture.thenUserCredentialsShouldBe(
              [builder.withName("BadName").withId("1").buildUserCredentials()]);
        });

        test("Alice add a empty name", () async {
          await fixture.whenUserAddCredentials(builder.withName("").buildMap());
          fixture.thenErrorShouldBe(EmptyNameError());
          await fixture.thenUserCredentialsShouldBe(List.empty());
        });

        test("Alice update with a empty name", () async {
          await fixture.givenExistingUsers(
              [builder.withName("BadName").withId("1").buildUserCredentials()]);
          await fixture.whenUserEditCredentials(
              builder.withName("").withId("1").buildMap());

          fixture.thenErrorShouldBe(EmptyNameError());
          await fixture.thenUserCredentialsShouldBe(
              [builder.withName("BadName").withId("1").buildUserCredentials()]);
        });
      });
    });
    group('User can connect with a existing user', () {
      test("Alice choose the profil Bob", () async {
        await fixture.givenExistingUsers([
          builder.withUsername("Bob").withId("First").buildUserCredentials(),
          builder
              .withUsername("Charlie")
              .withId("Second")
              .buildUserCredentials()
        ]);
        await fixture.whenUserLoginCredential("Second");

        await fixture.thenCurrentUserShouldBe(builder
            .withUsername("Charlie")
            .withId("Second")
            .buildUserCredentials());
      });

      test("Alice logout", () async {
        await fixture.givenExistingUsers([
          builder.withUsername("Bob").withName("First").buildUserCredentials(),
          builder
              .withUsername("Charlie")
              .withName("Second")
              .buildUserCredentials()
        ]);
        await fixture.givenCurrentUser(builder
            .withUsername("Charlie")
            .withName("Second")
            .buildUserCredentials());

        fixture.whenUserLogoutCredential();
        await fixture.thenCurrentUserShouldBe(null);
      });
    });
  });
}

class AuthentificationFixture {
  Error? error;
  late SecureStorageUserCredentialsRepository userRepository;
  late AddCredentialsUseCase addCredentialsUseCase;
  late EditCredentialsUseCase editCredentialsUseCase;
  late LoginCredentialsUseCase loginCredentialsUseCase;
  late LogoutCredentialsUseCase logoutCredentialsUseCase;

  AuthentificationFixture() {
    userRepository = SecureStorageUserCredentialsRepository();
    editCredentialsUseCase =
        EditCredentialsUseCase(userRepository: userRepository);
    loginCredentialsUseCase =
        LoginCredentialsUseCase(userRepository: userRepository);
    logoutCredentialsUseCase =
        LogoutCredentialsUseCase(userRepository: userRepository);
    addCredentialsUseCase =
        AddCredentialsUseCase(userRepository: userRepository);
  }

  Future<void> whenUserAddCredentials(Map<String, String> uc) async {
    try {
      await addCredentialsUseCase.handle(uc);
    } catch (e) {
      error = e as Error?;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> whenUserLoginCredential(String id) async {
    try {
      await loginCredentialsUseCase.handle(id);
    } catch (e) {
      error = e as Error?;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void whenUserLogoutCredential() async {
    try {
      await logoutCredentialsUseCase.handle();
    } catch (e) {
      error = e as Error?;
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
      error = e as Error?;
    }
  }

  Future<void> givenExistingUsers(List<UserCredentials> l) async {
    await userRepository.givenExistingUsers(l);
  }

  Future<void> givenCurrentUser(UserCredentials u) async {
    await userRepository.selectCurrentUser(u);
  }

  void thenErrorShouldBe<T extends Error>(T e) {
    expect(error, isA<T>());
  }

  Future<void> thenUserCredentialsShouldBe(List<UserCredentials> lu) async {
    var l = await userRepository.getAllUsers();
    assert(listEquals(l, lu));
  }

  Future<void> thenCurrentUserShouldBe(UserCredentials? user) async {
    UserCredentials? currentUser = userRepository.getCurrentUser();
    expect(currentUser, equals(user));
  }
}
