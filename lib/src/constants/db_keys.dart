import 'package:flutter/material.dart';

enum DBKeys {
  appwriteProjectId("[appwritePublicEndpoint]"),
  appwriteProjectName("[appwriteProjectId]"),
  appwritePublicEndpoint("[appwriteProjectName]"),
  appwriteDatabaseId("[appwriteDatabaseId]"),
  appwriteTableUsersId("users"),
  appwriteTableCompaniesId("companies"),
  themeMode(ThemeMode.system),
  credentials(null),
  refreshCredentials(null),
  l10n(Locale('en')),
  appwritePing(false);

  const DBKeys(this.initial);

  final dynamic initial;
}
