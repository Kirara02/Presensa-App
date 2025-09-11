import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:presensa_app/src/features/auth/providers/auth_provider.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    // Validasi form
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    try {
      await ref
          .read(authControllerProvider.notifier)
          .updatePassword(
            _oldPasswordController.text,
            _newPasswordController.text,
          );

      if (mounted) {
        context.showSnackBar('Password berhasil diperbarui!');
        context.pop(); // Kembali ke layar sebelumnya setelah sukses
      }
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
    return Scaffold(
      appBar: AppBar(title: const Text('Ubah Password')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _oldPasswordController,
                obscureText: _obscureOldPassword,
                decoration: InputDecoration(
                  labelText: 'Password Lama',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureOldPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () => setState(
                      () => _obscureOldPassword = !_obscureOldPassword,
                    ),
                  ),
                ),
                validator: (value) =>
                    (value?.isEmpty ?? true) ? 'Tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              // Field Password Baru
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  labelText: 'Password Baru',
                  helperText: 'Minimal 8 karakter',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () => setState(
                      () => _obscureNewPassword = !_obscureNewPassword,
                    ),
                  ),
                ),
                validator: (value) => (value?.length ?? 0) < 8
                    ? 'Password minimal 8 karakter'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureNewPassword,
                decoration: const InputDecoration(
                  labelText: 'Konfirmasi Password Baru',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Tidak boleh kosong';
                  if (value != _newPasswordController.text) {
                    return 'Password tidak cocok';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              // Tombol Simpan
              ElevatedButton(
                onPressed: _isLoading ? null : _changePassword,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
