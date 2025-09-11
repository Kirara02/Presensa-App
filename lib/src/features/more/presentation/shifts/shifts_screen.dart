import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/features/employees/data/models/shift.dart';
import 'package:presensa_app/src/features/employees/providers/shift_provider.dart';
import 'package:presensa_app/src/features/more/presentation/shifts/widgets/shift_form_dialog.dart';

class ShiftsScreen extends ConsumerWidget {
  const ShiftsScreen({super.key});

  void _showShiftFormDialog(BuildContext context, {Shift? shift}) {
    showDialog(
      context: context,
      builder: (context) => ShiftFormDialog(initialShift: shift),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shiftsAsync = ref.watch(shiftListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Jadwal Kerja (Shifts)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(shiftListProvider),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showShiftFormDialog(context),
        tooltip: 'Tambah Jadwal Baru',
        child: const Icon(Icons.add),
      ),
      body: shiftsAsync.when(
        data: (shifts) {
          if (shifts.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada jadwal kerja.\nTekan tombol + untuk menambah.',
              ),
            );
          }
          return ListView.builder(
            itemCount: shifts.length,
            itemBuilder: (context, index) {
              final shift = shifts[index];
              return ListTile(
                title: Text(shift.name),
                subtitle: Text(
                  '${shift.startTime} - ${shift.endTime} (${shift.timezone})',
                ),
                trailing: const Icon(Icons.edit_note), 
                onTap: () => _showShiftFormDialog(context, shift: shift),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Gagal memuat: $err')),
      ),
    );
  }
}
