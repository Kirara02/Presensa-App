import 'package:presensa_app/src/features/employees/data/models/employee.dart';

abstract class EmployeeRepository {
  Future<List<Employee>> getEmployees();

  Future<Employee> getEmployeeById(String documentId);

  Future<void> addEmployee({
    required String name,
    required String email,
    required String password,
    required String role,
    required String companyId,
    String? department,
    String? phone,
  });

  Future<Employee> updateEmployee(Employee employee);

  Future<void> deleteEmployee(String userId, String documentId);
}
