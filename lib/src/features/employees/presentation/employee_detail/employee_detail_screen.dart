import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/core/providers/user_data_provider.dart';
import 'package:presensa_app/src/features/employees/data/models/employee.dart';
import 'package:presensa_app/src/features/employees/providers/employee_provider.dart';
import 'package:presensa_app/src/features/employees/providers/shift_provider.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';

class EmployeeDetailScreen extends ConsumerStatefulWidget {
  final String employeeId;
  const EmployeeDetailScreen({super.key, required this.employeeId});

  @override
  ConsumerState<EmployeeDetailScreen> createState() =>
      _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends ConsumerState<EmployeeDetailScreen> {
  // --- State & Controllers ---
  bool _isEditing = false;
  bool _isUpdating = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _departmentController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedShiftId;
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  // --- Aksi & Logika ---
  void _initializeFields() {
    final employee = ref
        .read(employeeListProvider)
        .value
        ?.firstWhereOrNull((e) => e.documentId == widget.employeeId);
    if (employee != null) {
      _nameController.text = employee.name;
      _emailController.text = employee.email;
      _departmentController.text = employee.department ?? '';
      _phoneController.text = employee.phone ?? '';
      _selectedRole = employee.role;
      _selectedShiftId = employee.shift?.id;
    }
  }

  void _resetFieldsTo(Employee employee) {
    _nameController.text = employee.name;
    _emailController.text = employee.email;
    _departmentController.text = employee.department ?? '';
    _phoneController.text = employee.phone ?? '';
    setState(() {
      _selectedRole = employee.role;
      _selectedShiftId = employee.shift?.id;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _departmentController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _cancelEditing() {
    final employee = ref
        .read(employeeListProvider)
        .value!
        .firstWhereOrNull((e) => e.documentId == widget.employeeId)!;
    _resetFieldsTo(employee);
    setState(() => _isEditing = false);
    context.showSnackBar('Perubahan dibatalkan.');
  }

  Future<void> _updateEmployee(Employee currentEmployee) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isUpdating = true);
    final availableShifts = ref.read(shiftListProvider).value ?? [];
    final newShift = availableShifts.firstWhereOrNull(
      (s) => s.id == _selectedShiftId,
    );

    final updatedEmployee = currentEmployee.copyWith(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      role: _selectedRole ?? currentEmployee.role,
      department: _departmentController.text.trim().isNotEmpty
          ? _departmentController.text.trim()
          : null,
      phone: _phoneController.text.trim().isNotEmpty
          ? _phoneController.text.trim()
          : null,
      shift: newShift,
    );
    try {
      await ref
          .read(employeeListProvider.notifier)
          .updateEmployee(updatedEmployee);
      if (mounted) setState(() => _isEditing = false);
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(employeeListProvider, (previous, next) {
      if (previous != null && previous is AsyncLoading && previous.hasValue) {
        if (next is AsyncData) {
          context.showSnackBar('Data berhasil diperbarui');
        } else if (next is AsyncError) {
          context.showSnackBar('Gagal memperbarui: ${next.error}');
        }
      }
    });

    final employeeListAsync = ref.watch(employeeListProvider);
    final currentUser = ref.watch(userDataProvider).value;
    final shiftsAsync = ref.watch(shiftListProvider);
    final shifts = shiftsAsync.value;
    final employee = employeeListAsync.value?.firstWhereOrNull(
      (e) => e.documentId == widget.employeeId,
    );

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
        actions: [
          if (_isUpdating)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
            ),
        ],
        automaticallyImplyLeading: !_isEditing,
      ),
      floatingActionButton:
          (employee == null ||
              employee.role == 'super-admin' ||
              !employeeListAsync.hasValue)
          ? null
          : FloatingActionButton(
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
            ),
      body: (employeeListAsync.hasValue)
          ? (employee == null
                ? const Center(child: Text('Karyawan tidak ditemukan.'))
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            enabled:
                                _isEditing && employee.role != 'super-admin',
                            decoration: const InputDecoration(
                              labelText: 'Nama',
                            ),
                            validator: (v) => (v?.isEmpty ?? true)
                                ? 'Tidak boleh kosong'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailController,
                            enabled:
                                _isEditing && employee.role != 'super-admin',
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
                            validator: (v) => (v?.isEmpty ?? true)
                                ? 'Tidak boleh kosong'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          if (shifts != null && shifts.isNotEmpty)
                            DropdownButtonFormField<String>(
                              initialValue: _selectedShiftId,
                              decoration: const InputDecoration(
                                labelText: 'Jadwal Kerja (Shift)',
                              ),
                              items: shifts
                                  .map(
                                    (shift) => DropdownMenuItem(
                                      value: shift.id,
                                      child: Text(shift.name),
                                    ),
                                  )
                                  .toList(),
                              onChanged:
                                  _isEditing && employee.role != 'super-admin'
                                  ? (value) =>
                                        setState(() => _selectedShiftId = value)
                                  : null,
                              validator: (value) => value == null
                                  ? 'Jadwal kerja wajib dipilih'
                                  : null,
                            )
                          else
                            TextFormField(
                              enabled: false,
                              controller: TextEditingController(
                                text:
                                    employee.shift?.name ??
                                    (shiftsAsync.isLoading
                                        ? 'Memuat...'
                                        : 'Tidak ada'),
                              ),
                              decoration: const InputDecoration(
                                labelText: 'Jadwal Kerja',
                              ),
                            ),
                          const SizedBox(height: 16),
                          if (employee.role == 'super-admin')
                            TextFormField(
                              initialValue: 'Super Admin',
                              enabled: false,
                              decoration: const InputDecoration(
                                labelText: 'Jabatan',
                              ),
                            )
                          else if (currentUser?.isSuperAdmin == true)
                            DropdownButtonFormField<String>(
                              initialValue: _selectedRole,
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
                                  ? (String? newValue) =>
                                        setState(() => _selectedRole = newValue)
                                  : null,
                              validator: (value) =>
                                  value == null ? 'Peran harus dipilih' : null,
                            )
                          else
                            TextFormField(
                              initialValue: employee.role,
                              enabled: false,
                              decoration: const InputDecoration(
                                labelText: 'Jabatan',
                              ),
                            ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _departmentController,
                            enabled:
                                _isEditing && employee.role != 'super-admin',
                            decoration: const InputDecoration(
                              labelText: 'Departemen',
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _phoneController,
                            enabled:
                                _isEditing && employee.role != 'super-admin',
                            decoration: const InputDecoration(
                              labelText: 'Telepon',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
          : (employeeListAsync.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: Text(
                      'Gagal memuat data: ${employeeListAsync.error}',
                    ),
                  )),
    );
  }
}
