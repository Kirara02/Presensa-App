import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:presensa_app/src/core/providers/user_data_provider.dart';
import 'package:presensa_app/src/features/employees/data/models/shift.dart';
import 'package:presensa_app/src/features/employees/providers/employee_provider.dart';
import 'package:presensa_app/src/features/employees/providers/shift_provider.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';

class AddEmployeeScreen extends ConsumerStatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  ConsumerState<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends ConsumerState<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _departmentController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedShiftId;
  String _selectedRole = 'employee';
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _departmentController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveEmployee() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final currentUser = ref.read(userDataProvider).value;

    if (currentUser?.company?.id == null) {
      context.showSnackBar(
        'Tidak dapat menemukan ID perusahaan Anda. Silakan coba lagi.',
      );
      return;
    }
    final String companyId = currentUser!.company!.id;

    setState(() => _isLoading = true);

    try {
      await ref
          .read(employeeListProvider.notifier)
          .addEmployee(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            role: _selectedRole,
            companyId: companyId,
            department: _departmentController.text.isNotEmpty
                ? _departmentController.text.trim()
                : null,
            phone: _phoneController.text.isNotEmpty
                ? _phoneController.text.trim()
                : null,
            shiftId: _selectedShiftId!,
          );

      if (mounted) {
        context.showSnackBar('Karyawan berhasil ditambahkan!');
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar('Gagal menambahkan: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userDataProvider).value;
    final shiftsAsync = ref.watch(shiftListProvider);
    final List<Shift>? shifts = shiftsAsync.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Karyawan Baru'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: 'Simpan',
            onPressed: _isLoading ? null : _saveEmployee,
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: Center(child: CircularProgressIndicator(strokeWidth: 3)),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (value) =>
                    (value?.isEmpty ?? true) ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => (value?.isEmpty ?? true)
                    ? 'Email tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => (value?.length ?? 0) < 8
                    ? 'Password minimal 8 karakter'
                    : null,
              ),
              const SizedBox(height: 16),
              if (shifts != null && shifts.isNotEmpty)
                DropdownButtonFormField<String>(
                  initialValue: _selectedShiftId,
                  hint: const Text('Pilih Jadwal Kerja'),
                  decoration: const InputDecoration(labelText: 'Jadwal Kerja'),
                  items: shifts
                      .map(
                        (shift) => DropdownMenuItem(
                          value: shift.id,
                          child: Text(shift.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedShiftId = value),
                  validator: (value) => value == null ? 'Wajib dipilih' : null,
                )
              else
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Jadwal Kerja',
                    hintText: shiftsAsync.isLoading
                        ? 'Memuat jadwal...'
                        : 'Jadwal tidak tersedia',
                  ),
                ),
              const SizedBox(height: 16),
              if (currentUser?.role == 'super-admin') ...[
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
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedRole = newValue;
                      });
                    }
                  },
                  validator: (value) =>
                      value == null ? 'Peran harus dipilih' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _departmentController,
                  decoration: const InputDecoration(labelText: 'Departement'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
