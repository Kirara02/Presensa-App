import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/features/employees/providers/employee_provider.dart';
import 'package:presensa_app/src/routes/router_config.dart';

class EmployeesScreen extends ConsumerWidget {
  const EmployeesScreen({super.key});

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus karyawan ini? Tindakan ini tidak dapat diurungkan.',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(false), // Mengembalikan false
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(true), // Mengembalikan true
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tonton state dari provider kelas yang baru
    final employeeListAsync = ref.watch(employeeListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Karyawan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(employeeListProvider),
          ),
        ],
      ),
      body: employeeListAsync.when(
        data: (employees) {
          if (employees.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.people_outline,
                    size: 48,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text('Belum ada data karyawan.'),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => AddEmployeeRoute().go(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah Karyawan'),
                  ),
                ],
              ),
            );
          }
          // Gunakan ListView.separated untuk garis pemisah antar item
          return ListView.separated(
            itemCount: employees.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final employee = employees[index];

              // Gunakan Dismissible untuk fungsionalitas geser-untuk-hapus
              return Dismissible(
                key: ValueKey(
                  employee.documentId,
                ), // Kunci unik untuk setiap item
                direction:
                    DismissDirection.endToStart, // Arah geser (kanan ke kiri)
                // Tampilan latar belakang saat item digeser
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),

                // Tampilkan dialog konfirmasi sebelum menghapus
                confirmDismiss: (direction) async {
                  return await _showDeleteConfirmationDialog(context);
                },

                // Aksi yang dijalankan setelah item berhasil digeser dan dikonfirmasi
                onDismissed: (direction) {
                  ref
                      .read(employeeListProvider.notifier)
                      .deleteEmployee(employee.userId, employee.documentId);

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(content: Text('${employee.name} dihapus.')),
                    );
                },

                // Widget utama yang ditampilkan
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      employee.name.isNotEmpty ? employee.name[0] : '?',
                    ),
                  ),
                  title: Text(employee.name),
                  // Subtitle yang lebih kaya dengan data perusahaan
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(employee.role),
                      // Tampilkan nama perusahaan jika ada
                      if (employee.company != null)
                        Text(
                          employee.company!.name,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      // Tampilkan alamat jika ada
                      if (employee.company?.address != null)
                        Text(
                          employee.company!.address!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    EmployeeDetailRoute(employee.documentId).go(context);
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text('Terjadi kesalahan:\n$error', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(employeeListProvider),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddEmployeeRoute().go(context);
        },
        tooltip: 'Tambah Karyawan',
        child: const Icon(Icons.add),
      ),
    );
  }
}
