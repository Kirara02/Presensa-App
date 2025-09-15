import 'dart:convert';
import 'package:appwrite/appwrite.dart';
import 'package:presensa_app/src/constants/db_keys.dart';
import 'package:presensa_app/src/core/logger/logger.dart';
import 'package:presensa_app/src/core/providers/appwrite_provider.dart';
import 'package:presensa_app/src/features/employees/data/models/employee.dart';
import 'package:presensa_app/src/features/employees/data/repository/employee_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_service.g.dart';

class EmployeeService implements EmployeeRepository {
  final Functions _functions;

  final String databaseId = DBKeys.appwriteDatabaseId.initial;
  final String employeeFunctionId = DBKeys.appwriteFunctionEmployeeId.initial;
  final String usersTableId = DBKeys.appwriteTableUsersId.initial;

  EmployeeService({required Functions functions}) : _functions = functions;

  @override
  Future<void> addEmployee({
    required String name,
    required String email,
    required String password,
    required String role,
    required String companyId,
    String? department,
    String? phone,
    required String shiftId,
  }) async {
    try {
      final result = await _functions.createExecution(
        functionId: employeeFunctionId,
        body: jsonEncode({
          'action': 'create',
          'name': name,
          'email': email,
          'password': password,
          'role': role,
          'companyId': companyId,
          'department': department,
          'phone': phone,
          'shiftId': shiftId,
        }),
      );

      final response = jsonDecode(result.responseBody);
      logger.i(response);
      if (response['success'] != true) {
        throw Exception(
          response['error'] ?? 'Gagal membuat karyawan via fungsi',
        );
      }
    } on AppwriteException catch (e) {
      throw e.message ?? 'Gagal memanggil fungsi';
    } catch (e) {
      throw 'Terjadi kesalahan: $e';
    }
  }

  @override
  Future<void> deleteEmployee(String userId, String documentId) async {
    try {
      // --- LOGIKA BARU ---
      // Panggil Appwrite Function untuk menghapus user dan dokumen
      final result = await _functions.createExecution(
        functionId: employeeFunctionId,
        body: jsonEncode({
          'action': 'delete',
          'userId': userId,
          'documentId': documentId,
        }),
      );

      final response = jsonDecode(result.responseBody);
      logger.i(response);
      if (response['success'] != true) {
        throw Exception(
          response['error'] ?? 'Gagal menghapus karyawan via fungsi',
        );
      }
    } on AppwriteException catch (e) {
      throw e.message ?? 'Gagal memanggil fungsi';
    } catch (e) {
      throw 'Terjadi kesalahan: $e';
    }
  }

  @override
  Future<List<Employee>> getEmployees() async {
    try {
      final result = await _functions.createExecution(
        functionId: employeeFunctionId,
        body: jsonEncode({'action': 'list'}),
      );

      final Map<String, dynamic> decodedResponse = jsonDecode(
        result.responseBody,
      );

      if (decodedResponse['success'] == true) {
        final List<dynamic> dataList = decodedResponse['data'] as List<dynamic>;

        return dataList
            .map((item) => Employee.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Error dari server: ${decodedResponse['error']}');
      }
    } on AppwriteException catch (e) {
      throw e.message ?? 'Gagal memanggil fungsi getEmployees';
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<Employee> getEmployeeById(String documentId) async {
    try {
      final result = await _functions.createExecution(
        functionId: employeeFunctionId,
        body: jsonEncode({'action': 'getById', 'documentId': documentId}),
      );

      final Map<String, dynamic> decodedResponse = jsonDecode(
        result.responseBody,
      );
      if (decodedResponse['success'] == true) {
        return Employee.fromJson(
          decodedResponse['data'] as Map<String, dynamic>,
        );
      } else {
        throw Exception('Error dari server: ${decodedResponse['error']}');
      }
    } catch (e) {
      throw 'Gagal memuat detail karyawan: $e';
    }
  }

  @override
  Future<Employee> updateEmployee(Employee employee) async {
    try {
      final result = await _functions.createExecution(
        functionId: employeeFunctionId,
        body: jsonEncode({
          'action': 'update',
          'employeeData': employee.toJson(),
        }),
      );

      final Map<String, dynamic> decodedResponse = jsonDecode(
        result.responseBody,
      );
      if (decodedResponse['success'] == true) {
        return employee;
      } else {
        throw Exception('Error dari server: ${decodedResponse['error']}');
      }
    } catch (e) {
      throw 'Gagal memperbarui data karyawan: $e';
    }
  }
}

@riverpod
EmployeeRepository employeeRepository(Ref ref) =>
    EmployeeService(functions: ref.watch(appwriteFunctionsProvider));
