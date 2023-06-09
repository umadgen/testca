import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class UserCredentials extends Equatable {
  final String id;
  final NameText name;
  final UsernameText username;
  final PasswordText password;
  final UrlText baseUrl;

  UserCredentials._({
    String? id,
    required this.name,
    required this.baseUrl,
    required this.username,
    required this.password,
  }) : id = id ?? const Uuid().v4();

  String get getUsername {
    return username.value;
  }

  String get getPassword {
    return password.value;
  }

  Uri get getBaseUrl {
    return baseUrl.value;
  }

  String get getName {
    return name.value;
  }

  String get getId {
    return id;
  }

  UserCredentials copyWith(
          {String? i, String? n, String? u, String? p, String? bu}) =>
      UserCredentials._(
        id: i ?? id,
        name: n != null ? NameText.of(n) : name,
        username: u != null ? UsernameText.of(u) : username,
        password: p != null ? PasswordText.of(p) : password,
        baseUrl: bu != null ? UrlText.of(bu) : baseUrl,
      );
  Map toJson() => ({
        "id": id,
        "name": getName,
        "password": getPassword,
        "username": getUsername,
        "baseUrl": getBaseUrl.toString()
      });

  factory UserCredentials.fromData(Map<String, String> data) {
    return UserCredentials._(
      id: data['id']!,
      name: NameText.of(data['name']!),
      username: UsernameText.of(data["username"]!),
      baseUrl: UrlText.of(data["baseUrl"]!),
      password: PasswordText.of(data["password"]!),
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        baseUrl,
        name,
      ];
}

class UsernameText extends Equatable {
  final String value;

  const UsernameText._(this.value);

  static of(String value) {
    final String valueSanitized = value.trim();
    if (valueSanitized.isEmpty) {
      throw EmptyUsernameError();
    }
    if (valueSanitized.length > 280) {
      throw UsernameTooLongError();
    }
    return UsernameText._(value);
  }

  @override
  List<Object?> get props => [value];
}

class PasswordText extends Equatable {
  final String value;

  const PasswordText._(this.value);

  static of(String value) {
    final String valueSanitized = value.trim();
    if (valueSanitized.isEmpty) {
      throw EmptyPasswordError();
    }
    if (valueSanitized.length > 128) {
      throw PasswordTooLongError();
    }
    return PasswordText._(value);
  }

  @override
  List<Object?> get props => [value];
}

class NameText extends Equatable {
  final String value;

  const NameText._(this.value);

  static of(String value) {
    final String valueSanitized = value.trim();
    if (valueSanitized.isEmpty) {
      throw EmptyNameError();
    }
    if (valueSanitized.length > 128) {
      throw NameTooLongError();
    }
    return NameText._(value);
  }

  @override
  List<Object?> get props => [value];
}

class UrlText extends Equatable {
  final Uri value;

  const UrlText._(this.value);

  static of(String value) {
    final String valueSanitized = value.trim();
    if (valueSanitized.isEmpty) {
      throw EmptyUrlError();
    }
    if (valueSanitized.length > 128) {
      throw UrlTooLongError();
    }
    if (Uri.parse(value).isAbsolute == false) {
      throw UrlBadFormat();
    }
    return UrlText._(Uri.parse(value));
  }

  @override
  List<Object?> get props => [value];
}

class EmptyUrlError extends Error {}

class UrlBadFormat extends Error {}

class UrlTooLongError extends Error {}

class EmptyUsernameError extends Error {}

class UsernameTooLongError extends Error {}

class EmptyPasswordError extends Error {}

class PasswordTooLongError extends Error {}

class NameTooLongError extends Error {}

class EmptyNameError extends Error {}
