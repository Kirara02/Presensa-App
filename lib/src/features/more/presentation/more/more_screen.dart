import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/core/providers/user_data_provider.dart';
import 'package:presensa_app/src/features/auth/providers/auth_provider.dart';
import 'package:presensa_app/src/routes/router_config.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';

final _isLoggingOutProvider = StateProvider<bool>((ref) => false);

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userDataProvider).valueOrNull;
    final isLoggingOut = ref.watch(_isLoggingOutProvider);

    Future<void> performLogout() async {
      ref.read(_isLoggingOutProvider.notifier).state = true;
      try {
        await ref.read(authControllerProvider.notifier).logout();
      } catch (e) {
        if (context.mounted) {
          context.showSnackBar('Gagal logout: $e');
        }
      } finally {
        if (context.mounted) {
          ref.read(_isLoggingOutProvider.notifier).state = false;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n!.more)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(context.l10n!.profile),
            onTap: () {
              ProfileRoute().push(context);
            },
          ),

          if (userState?.isSuperAdmin ?? false)
            ListTile(
              leading: const Icon(Icons.business),
              title: Text(context.l10n!.company),
              onTap: () {
                CompanyRoute().push(context);
              },
            ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: Text(context.l10n!.change_password),
            onTap: () {
              ChangePasswordRoute().push(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(context.l10n!.settings),
            onTap: () async {
              SettingsRoute().push(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_rounded),
            title: Text(context.l10n!.about),
            onTap: () async {
              AboutRoute().push(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(context.l10n!.logout),
            trailing: isLoggingOut
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  )
                : null,
            // Nonaktifkan tombol saat proses logout berjalan
            enabled: !isLoggingOut,
            onTap: performLogout,
          ),
        ],
      ),
    );
  }
}
