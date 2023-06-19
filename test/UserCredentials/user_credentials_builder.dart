import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';

class UserCredentialsDataBuilder {
  Map<String, String> data;

  UserCredentialsDataBuilder(
      [this.data = const {
        "id": "52",
        "name": "nameeeeee",
        "username": "testeeeeee",
        "password": "password",
        "baseUrl": "http://www.google.fr"
      }]);

  UserCredentialsDataBuilder withUsername(String newUsername) {
    return UserCredentialsDataBuilder({
      "id": data["id"]!,
      "name": data["name"]!,
      "username": newUsername,
      "password": data["password"]!,
      "baseUrl": data["baseUrl"]!,
    });
  }

  UserCredentialsDataBuilder withPassword(String newPassword) {
    return UserCredentialsDataBuilder({
      "id": data["id"]!,
      "name": data["name"]!,
      "username": data["username"]!,
      "password": newPassword,
      "baseUrl": data["baseUrl"]!,
    });
  }

  UserCredentialsDataBuilder withBaseUrl(String newBaseUrl) {
    return UserCredentialsDataBuilder({
      "id": data["id"]!,
      "name": data["name"]!,
      "username": data["username"]!,
      "password": data["password"]!,
      "baseUrl": newBaseUrl,
    });
  }

  UserCredentialsDataBuilder withName(String newName) {
    return UserCredentialsDataBuilder({
      "id": data["id"]!,
      "name": newName,
      "username": data["username"]!,
      "password": data["password"]!,
      "baseUrl": data["baseUrl"]!,
    });
  }

  UserCredentialsDataBuilder withId(String newId) {
    return UserCredentialsDataBuilder({
      "id": newId,
      "name": data["name"]!,
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
