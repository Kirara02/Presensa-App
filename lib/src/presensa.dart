import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:presensa_app/src/core/providers/global_provider.dart';
import 'package:presensa_app/src/features/auth/data/services/auth_service.dart';
import 'package:presensa_app/src/features/more/presentation/settings/widgets/app_theme_selector/app_theme_selector.dart';
import 'package:presensa_app/src/features/more/presentation/settings/widgets/app_theme_theme/app_theme_mode_tile.dart';
import 'package:presensa_app/src/features/more/presentation/settings/widgets/is_true_black/is_true_black_tile.dart';
import 'package:presensa_app/src/l10n/generated/app_localizations.dart';
import 'package:presensa_app/src/routes/router_config.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';

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
    final appScheme = ref.watch(appSchemeProvider);
    final isTrueBlack = ref.watch(isTrueBlackProvider);

    return MaterialApp.router(
      builder: FToastBuilder(),
      onGenerateTitle: (context) => context.l10n!.app_name,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: appLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      theme:
          FlexThemeData.light(
            scheme: appScheme,
            fontFamily: "Poppins",
            useMaterial3: true,
            useMaterial3ErrorColors: true,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ).copyWith(
            tabBarTheme: const TabBarThemeData(
              tabAlignment: TabAlignment.center,
            ),
          ),
      darkTheme:
          FlexThemeData.dark(
            scheme: appScheme,
            fontFamily: "Poppins",
            useMaterial3: true,
            useMaterial3ErrorColors: true,
            darkIsTrueBlack: isTrueBlack.ifNull(),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ).copyWith(
            tabBarTheme: const TabBarThemeData(
              tabAlignment: TabAlignment.center,
            ),
          ),
      themeMode: appThemeMode,
      routerConfig: routes,
    );
  }
}
