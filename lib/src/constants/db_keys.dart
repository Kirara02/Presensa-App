import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

enum DBKeys {
  appwriteProjectId("[appwritePublicEndpoint]"),
  appwriteProjectName("[appwriteProjectId]"),
  appwritePublicEndpoint("[appwriteProjectName]"),
  appwriteDatabaseId("[appwriteDatabaseId]"),
  appwriteTableUsersId("users"),
  appwriteTableCompaniesId("companies"),
  themeMode(ThemeMode.system),
  isTrueBlack(false),
  flexScheme(FlexScheme.material),
  credentials(null),
  refreshCredentials(null),
  l10n(Locale('en')),
  appwritePing(false);

  const DBKeys(this.initial);

  final dynamic initial;
}
