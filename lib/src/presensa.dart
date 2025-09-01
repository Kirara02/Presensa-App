import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presensa_app/src/constants/theme.dart';
import 'package:presensa_app/src/core/providers/global_provider.dart';
import 'package:presensa_app/src/features/auth/data/services/auth_service.dart';
import 'package:presensa_app/src/l10n/generated/app_localizations.dart';
import 'package:presensa_app/src/routes/router_config.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';
import 'package:presensa_app/src/widgets/theme/app_theme_mode_tile.dart';

class PresensaApp extends ConsumerStatefulWidget {
  const PresensaApp({super.key});

  @override
  ConsumerState<PresensaApp> createState() => _PresensaAppState();
}

class _PresensaAppState extends ConsumerState<PresensaApp> {
  @override
  void initState() {
    super.initState();
    _initialSetup();
  }

  Future<void> _initialSetup() async {
    final appwritePing = ref.read(appwritePingProvider);

    if (appwritePing == true) return;

    final success = await _pingAppwrite();

    if (success) {
      ref.read(appwritePingProvider.notifier).state = true;
    } else {
      Fluttertoast.showToast(msg: "Tidak bisa terhubung ke server");
    }
  }

  Future<bool> _pingAppwrite() async {
    final authRepo = ref.read(authRepositoryProvider);
    return await authRepo.ping();
  }

  @override
  Widget build(BuildContext context) {
    final routes = ref.watch(routerConfigProvider);
    final appLocale = ref.watch(l10nProvider);
    final appThemeMode = ref.watch(appThemeModeProvider);

    return MaterialApp.router(
      builder: FToastBuilder(),
      onGenerateTitle: (context) => context.l10n!.app_name,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: appLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeMode,
      routerConfig: routes,
    );
  }
}
