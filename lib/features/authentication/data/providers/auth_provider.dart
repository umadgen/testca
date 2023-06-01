import 'package:flitv_ca/features/authentication/domain/repository/auth.securestorage.repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flitv_ca/features/authentication/data/repository/auth.repository.dart';

final authRepositoryProvider = StateProvider<AuthRepository>(
  (ref) {
    return SecureStorageAuthRepository();
  },
);

final userListProvider = FutureProvider((ref) async {
  // Récupère l'instance de Repository
  final repository = ref.watch(authRepositoryProvider);

  // Requête la liste des tâches
  return await repository.getAllUsers();
});
