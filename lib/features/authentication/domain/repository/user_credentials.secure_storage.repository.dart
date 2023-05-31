import 'dart:convert';

import 'package:flitv_ca/features/authentication/domain/repository/user_credentials.repository.dart';
import 'package:flitv_ca/features/authentication/domain/user_credentials.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUserCredentialsRepository
    implements UserCredentialsRepository {
  final storage = const FlutterSecureStorage();

  @override
  Future<List<UserCredentials>> getAllUsers() async {
    String? usersStored = await storage.read(key: "users");
    if (usersStored != null && usersStored.isNotEmpty) {
      var json = jsonDecode(usersStored);
      List<Map<String, dynamic>> users = List<Map<String, dynamic>>.from(json);
      return users
          .map((e) => UserCredentials.fromData(Map.castFrom(e)))
          .toList();
    }

    return List.empty(growable: true);
  }

  @override
  Future<void> save(UserCredentials user) async {
    List<UserCredentials> listUsers = await getAllUsers();
    try {
      UserCredentials userExist = await getByID(user.id);

      listUsers[listUsers.indexOf(userExist)] = user;
    } catch (error) {
      if (error is UserNotFound) {
        listUsers.add(user);
      } else {
        rethrow;
      }
    }
    _save(listUsers);
  }

  @override
  Future<UserCredentials> getByID(String id) async {
    UserCredentials userExist = (await getAllUsers()).firstWhere(
        (element) => element.id == id,
        orElse: () => throw UserNotFound());
    return userExist;
  }

  Future<void> _save(List<UserCredentials> user) async {
    storage.write(key: "users", value: jsonEncode(user));
  }
}
