import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/core/providers/user_data_provider.dart';
import 'package:presensa_app/src/features/auth/data/models/user.dart';
import 'package:presensa_app/src/features/employees/data/models/employee.dart';
import 'package:presensa_app/src/features/employees/providers/employee_provider.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';

class EmployeeDetailScreen extends ConsumerStatefulWidget {
  final String employeeId;
  const EmployeeDetailScreen({super.key, required this.employeeId});

  @override
  ConsumerState<EmployeeDetailScreen> createState() =>
      _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends ConsumerState<EmployeeDetailScreen> {
  bool _isEditing = false;
  bool _isUpdating = false;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _departmentController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedRole;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _departmentController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _updateEmployee(Employee currentEmployee) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isUpdating = true);

    final updatedEmployee = currentEmployee.copyWith(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      role: _selectedRole ?? currentEmployee.role,
      department: _departmentController.text.isNotEmpty
          ? _departmentController.text.trim()
          : null,
      phone: _phoneController.text.isNotEmpty
          ? _phoneController.text.trim()
          : null,
    );

    try {
      await ref
          .read(employeeListProvider.notifier)
          .updateEmployee(updatedEmployee);

      if (mounted) {
        context.showSnackBar('Data berhasil diperbarui');
        setState(() => _isEditing = false);
      }
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
    });
    context.showSnackBar('Perubahan dibatalkan.');
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(employeeListProvider, (previous, next) {
      if (next is AsyncError) {
        context.showSnackBar('Gagal memperbarui: ${next.error}');
      }
    });

    final employeeListAsync = ref.watch(employeeListProvider);
    final currentUser = ref.watch(userDataProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(
        leading: _isEditing
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: _cancelEditing,
                tooltip: 'Batal',
              )
            : null,
        title: Text(_isEditing ? 'Edit Karyawan' : 'Detail Karyawan'),
        automaticallyImplyLeading: !_isEditing,
      ),

      floatingActionButton: _buildFab(employeeListAsync),
      body: _buildBody(employeeListAsync, currentUser),
    );
  }

  Widget? _buildFab(AsyncValue<List<Employee>> employeeListAsync) {
    if (!employeeListAsync.hasValue) return null;

    final employee = employeeListAsync.value!.firstWhereOrNull(
      (e) => e.documentId == widget.employeeId,
    );

    if (employee == null || employee.role == 'super-admin') {
      return null;
    }

    return FloatingActionButton(
      onPressed: _isUpdating
          ? null
          : () {
              if (_isEditing) {
                _updateEmployee(employee);
              } else {
                setState(() => _isEditing = true);
              }
            },
      child: Icon(_isEditing ? Icons.save : Icons.edit),
    );
  }

  Widget _buildBody(
    AsyncValue<List<Employee>> employeeListAsync,
    User? currentUser,
  ) {
    if (employeeListAsync.hasValue) {
      final employees = employeeListAsync.value!;
      final employee = employees.firstWhereOrNull(
        (e) => e.documentId == widget.employeeId,
      );

      if (employee == null) {
        return const Center(child: Text('Karyawan tidak ditemukan.'));
      }

      if (!_isEditing) {
        _nameController.text = employee.name;
        _emailController.text = employee.email;
        _departmentController.text = employee.department ?? '';
        _phoneController.text = employee.phone ?? '';
        _selectedRole = employee.role;
      }

      return SingleChildScrollView(
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

              if (employee.role == 'super-admin')
                TextFormField(
                  initialValue: 'Super Admin',
                  enabled: false,
                  decoration: const InputDecoration(labelText: 'Jabatan'),
                )
              else if (currentUser?.isSuperAdmin == true)
                DropdownButtonFormField<String>(
                  initialValue: _selectedRole,
                  decoration: InputDecoration(labelText: context.l10n!.role),
                  items: [
                    DropdownMenuItem(
                      value: 'employee',
                      child: Text(context.l10n!.role_employee),
                    ),
                    DropdownMenuItem(
                      value: 'admin',
                      child: Text(context.l10n!.role_admin),
                    ),
                  ],
                  onChanged: _isEditing
                      ? (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedRole = newValue;
                            });
                          }
                        }
                      : null,
                  validator: (value) =>
                      value == null ? 'Peran harus dipilih' : null,
                )
              else
                TextFormField(
                  initialValue: employee.role,
                  enabled: false,
                  decoration: const InputDecoration(labelText: 'Jabatan'),
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _departmentController,
                enabled: _isEditing,
                decoration: const InputDecoration(labelText: 'Departement'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                enabled: _isEditing,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    }

    // Tampilkan loading awal HANYA jika belum ada data sama sekali
    if (employeeListAsync is AsyncLoading && !employeeListAsync.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }

    // Tampilkan error awal HANYA jika belum ada data sama sekali
    if (employeeListAsync is AsyncError && !employeeListAsync.hasValue) {
      return Center(
        child: Text('Gagal memuat data: ${employeeListAsync.error}'),
      );
    }

    // Fallback
    return const SizedBox.shrink();
  }
}
