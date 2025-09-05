import 'package:presensa_app/src/features/employees/data/models/employee.dart';
import 'package:presensa_app/src/features/employees/data/services/employee_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_provider.g.dart';

@riverpod
class EmployeeList extends _$EmployeeList {
  @override
  Future<List<Employee>> build() async {
    final repository = ref.watch(employeeRepositoryProvider);
    return repository.getEmployees();
  }

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

    state = const AsyncValue.loading();

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
      return repository.getEmployees();
    });
  }

  Future<void> deleteEmployee(String userId, String documentId) async {
    final repository = ref.read(employeeRepositoryProvider);
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await repository.deleteEmployee(userId, documentId);
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
