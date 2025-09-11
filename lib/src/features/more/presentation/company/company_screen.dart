import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/features/more/data/models/company.dart';
import 'package:presensa_app/src/features/more/providers/company_provider.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';

class CompanyScreen extends ConsumerStatefulWidget {
  const CompanyScreen({super.key});

  @override
  ConsumerState<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends ConsumerState<CompanyScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _cancelEditing() {
    setState(() => _isEditing = false);
    context.showSnackBar('Perubahan dibatalkan.');
  }

  Future<void> _updateCompany(Company currentCompany) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final updatedCompany = currentCompany.copyWith(
      name: _nameController.text.trim(),
      address: _addressController.text.trim().isNotEmpty
          ? _addressController.text.trim()
          : null,
      location: _locationController.text.trim().isNotEmpty
          ? _locationController.text.trim()
          : null,
    );

    await ref.read(companyDataProvider.notifier).updateCompany(updatedCompany);

    if (mounted) setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<Company?>>(companyDataProvider, (previous, next) {
      if (previous != null && previous is AsyncLoading && previous.hasValue) {
        if (next is AsyncData) {
          context.showSnackBar('Data perusahaan berhasil diperbarui');
        } else if (next is AsyncError) {
          // 'next.error' akan berisi pesan error yang sebenarnya.
          context.showSnackBar('Gagal memperbarui: ${next.error}');
        }
      }
    });

    final companyAsync = ref.watch(companyDataProvider);
    final isUpdating = companyAsync.isLoading && companyAsync.hasValue;
    final Company? company = companyAsync.valueOrNull;

    if (company != null && !_isEditing && _nameController.text.isEmpty) {
      _nameController.text = company.name;
      _addressController.text = company.address ?? '';
      _locationController.text = company.location ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        leading: _isEditing
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: _cancelEditing,
              )
            : null,
        title: Text(_isEditing ? 'Edit Perusahaan' : 'Detail Perusahaan'),
        actions: [
          if (company != null && !_isEditing && !isUpdating)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => _isEditing = true),
            ),
        ],
        automaticallyImplyLeading: !_isEditing,
      ),
      floatingActionButton: _isEditing && company != null
          ? FloatingActionButton(
              onPressed: isUpdating ? null : () => _updateCompany(company),
              child: isUpdating
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Icon(Icons.check),
            )
          : null,
      body: _buildBody(companyAsync),
    );
  }

  Widget _buildBody(AsyncValue<Company?> companyAsync) {
    if (!companyAsync.hasValue) {
      if (companyAsync is AsyncError) {
        return Center(child: Text('Gagal memuat data: ${companyAsync.error}'));
      }
      return const Center(child: CircularProgressIndicator());
    }

    if (companyAsync.value == null) {
      return const Center(child: Text('Data perusahaan tidak ditemukan.'));
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
              decoration: const InputDecoration(labelText: 'Nama Perusahaan'),
              validator: (v) =>
                  (v?.isEmpty ?? true) ? 'Tidak boleh kosong' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              enabled: _isEditing,
              decoration: const InputDecoration(labelText: 'Alamat'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              enabled: _isEditing,
              decoration: const InputDecoration(
                labelText: 'Lokasi (Latitude, Longitude)',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
