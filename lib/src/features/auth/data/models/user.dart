import 'package:presensa_app/src/features/employees/data/models/company.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? department;
  final String? phone;
  final Company? company;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.department,
    this.phone,
    this.company,
  });

  bool get isSuperAdmin => role.toLowerCase() == 'super-admin';

  bool get isAdmin => role.toLowerCase() == 'admin';

  bool get isEmployee => role.toLowerCase() == 'employee';

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, role: $role, department: $department, phone: $phone, company: ${company.toString()})';
  }
}
