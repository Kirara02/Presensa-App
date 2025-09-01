class User {
  final String id;
  final String name;
  final String email;
  final String role; // e.g., 'admin', 'employee'
  final String? department;
  final String? phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.department,
    this.phone,
  });

  bool get isAdmin => role.toLowerCase() == 'admin';

  bool get isEmployee => role.toLowerCase() == 'employee';

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, role: $role, department: $department, phone: $phone)';
  }
}
