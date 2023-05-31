import 'package:flitv_ca/features/authentication/domain/user_credentials.dart';

class UserCredentialsDataBuilder {
  Map<String, String> data;

  UserCredentialsDataBuilder(
      [this.data = const {
        "id": "1",
        "username": "test",
        "password": "password",
        "baseUrl": "http://www.google.fr"
      }]);

  UserCredentialsDataBuilder withUsername(String newUsername) {
    return UserCredentialsDataBuilder({
      "id": data["id"]!,
      "username": newUsername,
      "password": data["password"]!,
      "baseUrl": data["baseUrl"]!,
    });
  }

  UserCredentialsDataBuilder withPassword(String newPassword) {
    return UserCredentialsDataBuilder({
      "id": data["id"]!,
      "username": data["username"]!,
      "password": newPassword,
      "baseUrl": data["baseUrl"]!,
    });
  }

  UserCredentialsDataBuilder withBaseUrl(String newBaseUrl) {
    return UserCredentialsDataBuilder({
      "id": data["id"]!,
      "username": data["username"]!,
      "password": data["password"]!,
      "baseUrl": newBaseUrl,
    });
  }

  UserCredentialsDataBuilder withId(String newId) {
    return UserCredentialsDataBuilder({
      "id": newId,
      "username": data["username"]!,
      "password": data["password"]!,
      "baseUrl": data["baseUrl"]!,
    });
  }

  Map<String, String> buildMap() {
    return data;
  }

  UserCredentials buildUserCredentials() {
    return UserCredentials.fromData(data);
  }
}
