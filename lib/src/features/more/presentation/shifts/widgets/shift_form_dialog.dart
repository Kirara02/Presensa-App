import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/features/employees/data/models/shift.dart';
import 'package:presensa_app/src/features/employees/providers/shift_provider.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';

// ignore: constant_identifier_names
enum WorkDay { MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY }

class ShiftFormDialog extends ConsumerStatefulWidget {
  final Shift? initialShift;

  const ShiftFormDialog({super.key, this.initialShift});

  @override
  ConsumerState<ShiftFormDialog> createState() => _ShiftFormDialogState();
}

class _ShiftFormDialogState extends ConsumerState<ShiftFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _toleranceController = TextEditingController(text: '10');

  // State untuk dropdown timezone
  String _selectedTimezone = 'Asia/Jakarta';

  // State untuk toggle hari kerja
  final Map<WorkDay, bool> _workDays = {
    WorkDay.MONDAY: true,
    WorkDay.TUESDAY: true,
    WorkDay.WEDNESDAY: true,
    WorkDay.THURSDAY: true,
    WorkDay.FRIDAY: true,
    WorkDay.SATURDAY: false,
    WorkDay.SUNDAY: false,
  };

  bool _isLoading = false;

  bool get _isEditMode => widget.initialShift != null;

  @override
  void initState() {
    super.initState();
    if (_isEditMode) {
      final shift = widget.initialShift!;
      _nameController.text = shift.name;
      _startTimeController.text = shift.startTime;
      _endTimeController.text = shift.endTime;
      _toleranceController.text = shift.lateToleranceMinutes.toString();
      _selectedTimezone = shift.timezone;
      for (var day in WorkDay.values) {
        _workDays[day] = shift.workDays.contains(day.name);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _toleranceController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (context.mounted && picked != null) {
      controller.text = picked.format(context);
    }
  }

  Future<void> _saveShift() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    final selectedWorkDays = _workDays.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key.name)
        .toList();

    if (selectedWorkDays.isEmpty) {
      context.showSnackBar('Pilih setidaknya satu hari kerja.');
      setState(() => _isLoading = false);
      return;
    }

    try {
      if (_isEditMode) {
        // --- LOGIKA EDIT ---
        final updatedShift = widget.initialShift!.copyWith(
          name: _nameController.text.trim(),
          startTime: _startTimeController.text,
          endTime: _endTimeController.text,
          timezone: _selectedTimezone,
          workDays: selectedWorkDays,
          lateToleranceMinutes: int.tryParse(_toleranceController.text) ?? 0,
        );
        await ref.read(shiftListProvider.notifier).updateShift(updatedShift);
        if (mounted) context.showSnackBar('Jadwal kerja berhasil diperbarui');
      } else {
        final newShift = Shift(
          id: '',
          name: _nameController.text.trim(),
          startTime: _startTimeController.text,
          endTime: _endTimeController.text,
          timezone: _selectedTimezone,
          workDays: selectedWorkDays,
          lateToleranceMinutes: int.tryParse(_toleranceController.text) ?? 0,
        );
        await ref.read(shiftListProvider.notifier).addShift(newShift);
        if (mounted) context.showSnackBar('Jadwal kerja berhasil ditambahkan');
      }
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        context.showSnackBar('Gagal: $e');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _isEditMode ? 'Edit Jadwal Kerja' : 'Tambah Jadwal Kerja Baru',
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Jadwal'),
                validator: (v) => (v?.isEmpty ?? true) ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _startTimeController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Jam Masuk'),
                onTap: () => _selectTime(context, _startTimeController),
                validator: (v) => (v?.isEmpty ?? true) ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _endTimeController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Jam Pulang'),
                onTap: () => _selectTime(context, _endTimeController),
                validator: (v) => (v?.isEmpty ?? true) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              // Input Toleransi Keterlambatan
              TextFormField(
                controller: _toleranceController,
                decoration: const InputDecoration(
                  labelText: 'Toleransi Terlambat (menit)',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Wajib diisi';
                  if (int.tryParse(v) == null) return 'Harus angka';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Dropdown Timezone
              DropdownButtonFormField<String>(
                initialValue: _selectedTimezone,
                decoration: const InputDecoration(labelText: 'Zona Waktu'),
                items: const [
                  DropdownMenuItem(
                    value: 'Asia/Jakarta',
                    child: Text('WIB (Asia/Jakarta)'),
                  ),
                  DropdownMenuItem(
                    value: 'Asia/Makassar',
                    child: Text('WITA (Asia/Makassar)'),
                  ),
                  DropdownMenuItem(
                    value: 'Asia/Jayapura',
                    child: Text('WIT (Asia/Jayapura)'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _selectedTimezone = value);
                },
              ),
              const SizedBox(height: 24),

              // Pemilih Hari Kerja
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hari Kerja',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                spacing: 4.0,
                runSpacing: 0.0,
                children: WorkDay.values.map((day) {
                  return FilterChip(
                    label: Text(day.name.substring(0, 3)),
                    selected: _workDays[day]!,
                    onSelected: (bool selected) {
                      setState(() {
                        _workDays[day] = selected;
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _saveShift,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Simpan'),
        ),
      ],
    );
  }
}
