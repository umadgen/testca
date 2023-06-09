import 'package:flitv_ca/features/authentication/data/repository/auth.repository.dart';
import 'package:flitv_ca/features/authentication/domain/repository/auth.inmemory.repository.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
AuthenticationRepository authRepository(AuthRepositoryRef ref) =>
    InMemoryAuth();
