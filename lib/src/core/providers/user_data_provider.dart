import 'package:presensa_app/src/features/auth/data/models/user.dart';
import 'package:presensa_app/src/features/auth/data/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  FutureOr<User?> build() async {
    final authRepository = ref.watch(authRepositoryProvider);
    return await authRepository.getCurrentUser();
  }

  void setUser(User user) {
    state = AsyncData(user);
  }

  Future<void> updateProfile(User updatedUser) async {
    final authRepository = ref.read(authRepositoryProvider);
    
    state = const AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      return authRepository.updateCurrentUser(updatedUser);
    });
  }
}
