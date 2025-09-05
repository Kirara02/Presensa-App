import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/core/providers/user_data_provider.dart';
import 'package:presensa_app/src/features/employees/data/models/employee.dart';
import 'package:presensa_app/src/features/employees/providers/employee_provider.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';

class EmployeeDetailScreen extends ConsumerStatefulWidget {
  final String employeeId; // Menerima documentId
  const EmployeeDetailScreen({super.key, required this.employeeId});

  @override
  ConsumerState<EmployeeDetailScreen> createState() =>
      _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends ConsumerState<EmployeeDetailScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  String? _selectedRole;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _updateEmployee(Employee currentEmployee) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    // Buat objek yang sudah diupdate dari data form
    final updatedEmployee = currentEmployee.copyWith(
      name: _nameController.text,
      email: _emailController.text,
      role: _selectedRole ?? currentEmployee.role,
    );

    try {
      await ref
          .read(employeeListProvider.notifier)
          .updateEmployee(updatedEmployee);

      if (mounted) {
        context.showSnackBar('Data berhasil diperbarui');
        setState(() => _isEditing = false);
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar('Gagal memperbarui: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final employeeListAsync = ref.watch(employeeListProvider);
    final currentUser = ref.watch(userDataProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Karyawan')),
      body: employeeListAsync.when(
        data: (employees) {
          // Cari karyawan yang sesuai dari daftar berdasarkan ID
          final Employee? employee = employees.firstWhereOrNull(
            (e) => e.documentId == widget.employeeId,
          );

          // Handle jika karyawan tidak ditemukan (misal sudah dihapus atau ada error)
          if (employee == null) {
            return const Center(
              child: Text('Karyawan tidak ditemukan. Mungkin sudah dihapus.'),
            );
          }

          // Isi controller dengan data saat ini (hanya jika tidak sedang mengedit)
          if (!_isEditing) {
            _nameController.text = employee.name;
            _emailController.text = employee.email;
            _selectedRole = employee.role;
          }

          return Scaffold(
            // Gunakan Scaffold kedua agar FAB tidak konflik
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (_isEditing) {
                  _updateEmployee(employee);
                } else {
                  setState(() => _isEditing = true);
                }
              },
              child: Icon(_isEditing ? Icons.save : Icons.edit),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      enabled: _isEditing,
                      decoration: const InputDecoration(labelText: 'Nama'),
                      validator: (v) =>
                          (v?.isEmpty ?? true) ? 'Tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      enabled: _isEditing,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (v) =>
                          (v?.isEmpty ?? true) ? 'Tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 16),
                    // 1. Periksa apakah pengguna yang DILIHAT adalah super-admin
                    if (employee.role == 'super-admin') ...[
                      // Jika ya, JANGAN tampilkan dropdown. Cukup tampilkan
                      // perannya sebagai teks non-editable.
                      TextFormField(
                        initialValue: 'Super Admin',
                        enabled: false,
                        decoration: const InputDecoration(labelText: 'Jabatan'),
                      ),
                    ]
                    // 2. Jika bukan, periksa apakah pengguna yang MELIHAT adalah super-admin
                    else if (currentUser?.isSuperAdmin == true) ...[
                      // Jika ya, tampilkan dropdown seperti sebelumnya.
                      DropdownButtonFormField<String>(
                        initialValue:
                            _selectedRole, // 'value' aman digunakan di sini
                        decoration: const InputDecoration(
                          labelText: 'Peran (Role)',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'employee',
                            child: Text('Karyawan (Employee)'),
                          ),
                          DropdownMenuItem(
                            value: 'admin',
                            child: Text('Admin'),
                          ),
                        ],
                        onChanged: _isEditing
                            ? (String? newValue) {
                                if (newValue != null) {
                                  setState(() => _selectedRole = newValue);
                                }
                              }
                            : null,
                        validator: (value) =>
                            value == null ? 'Peran harus dipilih' : null,
                      ),
                    ]
                    // 3. Jika bukan keduanya, tampilkan peran sebagai teks non-editable
                    else ...[
                      TextFormField(
                        initialValue: employee.role,
                        enabled: false,
                        decoration: const InputDecoration(labelText: 'Jabatan'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Gagal memuat: $err')),
      ),
    );
  }
}
