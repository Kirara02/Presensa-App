import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/constants/language_list.dart';
import 'package:presensa_app/src/core/providers/global_provider.dart';
import 'package:presensa_app/src/features/settings/presentation/settings/widgets/app_theme_selector/app_theme_selector.dart';
import 'package:presensa_app/src/features/settings/presentation/settings/widgets/app_theme_theme/app_theme_mode_tile.dart';
import 'package:presensa_app/src/features/settings/presentation/settings/widgets/is_true_black/is_true_black_tile.dart';
import 'package:presensa_app/src/l10n/generated/app_localizations.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';
import 'package:presensa_app/src/widgets/radio_list_popup.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n!.settings)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.translate_rounded),
            title: Text(context.l10n!.app_language),
            subtitle: Text(getLanguageNameFormLocale(context.currentLocale)),
            onTap: () => showDialog(
              context: context,
              builder: (context) => RadioListPopup<Locale>(
                title: context.l10n!.app_language,
                optionList: AppLocalizations.supportedLocales,
                value: context.currentLocale,
                onChange: (locale) {
                  ref.read(l10nProvider.notifier).update(locale);
                  Navigator.pop(context);
                },
                getOptionTitle: getLanguageNameFormLocale,
                getOptionSubtitle: getLanguageNameInEnFormLocale,
              ),
            ),
          ),
          const AppThemeModeTile(),
          const AppThemeSelector(),
          const IsTrueBlackTile(),
         
        ],
      ),
    );
  }
}
