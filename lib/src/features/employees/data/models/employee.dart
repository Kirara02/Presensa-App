import 'package:presensa_app/src/core/logger/logger.dart';
import 'package:presensa_app/src/features/employees/data/models/company.dart';

class Employee {
  final String userId;
  final String documentId;
  final String name;
  final String email;
  final String role;
  final String? department;
  final String? phone;
  final Company? company;

  Employee({
    required this.userId,
    required this.documentId,
    required this.name,
    required this.email,
    required this.role,
    this.department,
    this.phone,
    this.company,
  });

  // Factory constructor untuk membuat Employee dari JSON (data Appwrite)
  factory Employee.fromJson(Map<String, dynamic> json) {
    logger.i(json);
    return Employee(
      userId: json['userId'],
      documentId: json['documentId'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      department: json['department'],
      phone: json['phone'],
      company: json['company'] != null
          ? Company.fromJson(json['company'] as Map<String, dynamic>)
          : null,
    );
  }

  // Method untuk mengubah Employee menjadi JSON (untuk dikirim ke Appwrite)
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'documentId': documentId,
      'name': name,
      'email': email,
      'role': role,
      'department': department,
      'phone': phone,
    };
  }

  Employee copyWith({
    String? userId,
    String? documentId,
    String? name,
    String? email,
    String? role,
    String? department,
    String? phone,
  }) {
    return Employee(
      userId: userId ?? this.userId,
      documentId: documentId ?? this.documentId,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      department: department ?? this.department,
      phone: phone ?? this.phone,
    );
  }
}
