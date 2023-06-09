import 'dart:convert';

import 'package:flitv_ca/features/authentication/data/repository/user.repository.dart';
import 'package:flitv_ca/features/authentication/data/models/user_credentials.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUserRepository implements UserRepository {
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
      UserCredentials existingUser = await getUser(user.id);
      listUsers[listUsers.indexOf(existingUser)] = user;
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
  Future<UserCredentials> getUser(String id) async {
    final List<UserCredentials> allUsers = await getAllUsers();
    return allUsers.firstWhere((element) => element.id == id,
        orElse: () => throw UserNotFound());
  }

  Future<void> _save(List<UserCredentials> user) async {
    storage.write(key: "users", value: jsonEncode(user));
  }

  @override
  Future<void> givenExistingUsers(List<UserCredentials> users) async {
    await _save(users);
  }
}
