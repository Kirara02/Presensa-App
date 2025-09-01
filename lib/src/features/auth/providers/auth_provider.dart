import 'package:presensa_app/src/core/providers/user_data_provider.dart';
import 'package:presensa_app/src/features/auth/data/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() async {
    // default tidak ada action
  }

  /// login dan update UserData provider
  Future<void> login(String email, String password) async {
    state = const AsyncLoading();

    final repo = ref.read(authRepositoryProvider);

    state = await AsyncValue.guard(() async {
      final user = await repo.login(email, password);
      ref.read(userDataProvider.notifier).setUser(user);
    });
  }

  /// register lalu set UserData
  Future<void> register(String email, String password, String name) async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);

    state = await AsyncValue.guard(() async {
      await repo.register(email, password, name);
    });
  }

  /// logout dan clear UserData
  Future<void> logout() async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);

    state = await AsyncValue.guard(() async {
      await repo.logout();
      ref.invalidate(userDataProvider);
    });
  }

  /// refresh session (cek apakah user masih login)
  Future<void> loadCurrentUser() async {
    state = const AsyncLoading();
    final repo = ref.read(authRepositoryProvider);

    state = await AsyncValue.guard(() async {
      final user = await repo.getCurrentUser();
      if (user != null) {
        ref.read(userDataProvider.notifier).setUser(user);
      }
    });
  }

  /// ping server
  Future<bool> ping() async {
    final repo = ref.read(authRepositoryProvider);
    return await repo.ping();
  }
}
