import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/core/providers/user_data_provider.dart';
import 'package:presensa_app/src/features/auth/data/models/user.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _departmentController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _departmentController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _cancelEditing() {
    setState(() => _isEditing = false);
    context.showSnackBar('Perubahan dibatalkan.');
  }

  Future<void> _updateProfile(User currentUser) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final updatedUser = currentUser.copyWith(
      name: _nameController.text.trim(),
      department: _departmentController.text.trim().isNotEmpty
          ? _departmentController.text.trim()
          : null,
      phone: _phoneController.text.trim().isNotEmpty
          ? _phoneController.text.trim()
          : null,
    );

    // Panggil metode update dari Notifier UserData.
    // ref.listen akan menangani feedback-nya (sukses/gagal).
    await ref.read(userDataProvider.notifier).updateProfile(updatedUser);

    // Matikan mode edit setelah proses selesai, jika widget masih ada.
    if (mounted) setState(() => _isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    // Dengarkan perubahan state provider untuk menampilkan notifikasi.
    ref.listen<AsyncValue<User?>>(userDataProvider, (previous, next) {
      if (previous is AsyncLoading) {
        if (next is AsyncData) {
          context.showSnackBar('Profil berhasil diperbarui');
        } else if (next is AsyncError) {
          context.showSnackBar('Gagal memperbarui: ${next.error}');
        }
      }
    });

    final userAsync = ref.watch(userDataProvider);

    // Dapatkan data user terakhir yang valid. Akan null jika belum pernah ada data.
    final User? user = userAsync.valueOrNull;
    // Tentukan apakah ada proses update/loading yang sedang berjalan
    final isUpdating = userAsync.isLoading;

    // Isi controller dengan data JIKA BELUM diisi dan JIKA TIDAK sedang mengedit.
    // Ini penting agar nilai di form tidak ter-reset saat state provider menjadi loading.
    if (user != null && !_isEditing && _nameController.text.isEmpty) {
      _nameController.text = user.name;
      _departmentController.text = user.department ?? '';
      _phoneController.text = user.phone ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        leading: _isEditing
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: _cancelEditing,
                tooltip: 'Batal',
              )
            : null,
        title: Text(_isEditing ? 'Edit Profil' : 'Profil Saya'),
        actions: [
          // Tampilkan tombol Edit hanya jika ADA data dan TIDAK sedang mengedit/updating
          if (user != null && !_isEditing && !isUpdating)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => _isEditing = true),
              tooltip: 'Edit Profil',
            ),
        ],
        automaticallyImplyLeading: !_isEditing,
      ),
      floatingActionButton: _isEditing && user != null
          ? FloatingActionButton(
              onPressed: isUpdating ? null : () => _updateProfile(user),
              tooltip: 'Simpan',
              child: isUpdating
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    )
                  : const Icon(Icons.check),
            )
          : null,

      // --- BODY UTAMA ---
      // Tampilkan UI berdasarkan state, tetapi dengan satu Scaffold
      body: _buildBody(userAsync),
    );
  }

  Widget _buildBody(AsyncValue<User?> userAsync) {
    // Jika state adalah error TAPI BELUM PERNAH ADA DATA SEBELUMNYA,
    // tampilkan pesan error besar.
    if (userAsync is AsyncError && !userAsync.hasValue) {
      return Center(child: Text('Gagal memuat profil: ${userAsync.error}'));
    }

    // Jika state loading TAPI BELUM PERNAH ADA DATA SEBELUMNYA,
    // tampilkan indikator loading.
    if (!userAsync.hasValue) {
      // Ini mencakup loading awal
      return const Center(child: CircularProgressIndicator());
    }

    // Jika kita sampai di sini, artinya kita punya data (userAsync.hasValue adalah true).
    // Kita bisa dengan aman mengambil data `user` dari value.
    final user = userAsync.value!;

    // Selalu tampilkan form, baik saat loading/sukses/error (jika sudah ada data).
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
            // Email tidak bisa diubah, gunakan initialValue karena controller tidak ada.
            TextFormField(
              initialValue: user.email,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Email (tidak dapat diubah)',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _departmentController,
              enabled: _isEditing,
              decoration: const InputDecoration(labelText: 'Departemen'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              enabled: _isEditing,
              decoration: const InputDecoration(labelText: 'Telepon'),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}
