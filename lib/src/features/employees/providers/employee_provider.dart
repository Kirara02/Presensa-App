import 'package:presensa_app/src/features/employees/data/models/employee.dart';
import 'package:presensa_app/src/features/employees/data/services/employee_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_provider.g.dart';

@riverpod
class EmployeeList extends _$EmployeeList {
  /// Metode `build` adalah tempat di mana data awal diambil.
  /// Riverpod akan secara otomatis menangani state loading/error dari Future ini.
  @override
  Future<List<Employee>> build() async {
    final repository = ref.watch(employeeRepositoryProvider);
    // Kembalikan data awal saat provider ini pertama kali dibaca.
    return repository.getEmployees();
  }

  /// Menambahkan karyawan baru dan me-refresh daftar.
  Future<void> addEmployee({
    required String name,
    required String email,
    required String password,
    required String role,
    required String companyId,
    String? department,
    String? phone,
  }) async {
    final repository = ref.read(employeeRepositoryProvider);

    // Tetapkan state ke loading untuk memberikan feedback ke UI
    state = const AsyncValue.loading();

    // Gunakan AsyncValue.guard untuk menangani error secara otomatis.
    // Ini akan menjalankan Future, dan jika berhasil, akan me-refresh
    // state dengan data baru. Jika gagal, akan mengatur state ke error.
    state = await AsyncValue.guard(() async {
      await repository.addEmployee(
        name: name,
        email: email,
        password: password,
        role: role,
        companyId: companyId,
        department: department,
        phone: phone,
      );
      // Setelah berhasil menambahkan, ambil kembali daftar terbaru.
      return repository.getEmployees();
    });
  }

  /// Menghapus karyawan dan me-refresh daftar.
  Future<void> deleteEmployee(String userId, String documentId) async {
    final repository = ref.read(employeeRepositoryProvider);
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await repository.deleteEmployee(userId, documentId);
      // Setelah berhasil menghapus, ambil kembali daftar terbaru.
      return repository.getEmployees();
    });
  }

  Future<void> updateEmployee(Employee updatedEmployee) async {
    final repository = ref.read(employeeRepositoryProvider);
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await repository.updateEmployee(updatedEmployee);
      return repository.getEmployees();
    });
  }
}
