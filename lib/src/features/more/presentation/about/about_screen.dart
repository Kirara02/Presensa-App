import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/core/providers/global_provider.dart';
import 'package:presensa_app/src/features/more/presentation/about/widgets/clipboard_list_tile.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';
import 'package:presensa_app/src/widgets/app_logo.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfo = ref.watch(packageInfoProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        children: [
          AppLogo(),
          const Divider(),
          ClipboardListTile(
            title: context.l10n!.client,
            value: packageInfo.appName,
          ),
          ClipboardListTile(
            title: context.l10n!.client_version,
            value: "v${packageInfo.version}",
          ),
          ListTile(title: Text(context.l10n!.check_for_updates), onTap: () {}),
        ],
      ),
    );
  }
}
