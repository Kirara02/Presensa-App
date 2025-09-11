import 'package:presensa_app/src/core/providers/user_data_provider.dart';
import 'package:presensa_app/src/features/employees/data/models/shift.dart';
import 'package:presensa_app/src/features/employees/data/services/shift_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shift_provider.g.dart';

@riverpod
class ShiftList extends _$ShiftList {
  @override
  Future<List<Shift>> build() async {
    final companyId = ref.watch(userDataProvider).valueOrNull?.company?.id;
    if (companyId == null) return [];
    return ref.watch(shiftRepositoryProvider).getShiftsByCompany(companyId);
  }

  Future<void> addShift(Shift newShift) async {
    final companyId = ref.read(userDataProvider).valueOrNull?.company?.id;
    if (companyId == null) throw Exception('Company ID tidak ditemukan');

    final repository = ref.read(shiftRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repository.addShift(newShift, companyId);
      return build();
    });
  }

  Future<void> updateShift(Shift updatedShift) async {
    final repository = ref.read(shiftRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repository.updateShift(updatedShift);
      return build();
    });
  }
}
