import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

enum DBKeys {
  appwriteProjectId("68b1bd5b000a794c3435"),
  appwriteProjectName("Presensa"),
  appwritePublicEndpoint("https://syd.cloud.appwrite.io/v1"),
  appwriteDatabaseId("68b2d0250003a89951f0"),
  appwriteFunctionEmployeeId("68b94e040026ba9b8d70"),
  // appwriteProjectId("[appwritePublicEndpoint]"),
  // appwriteProjectName("[appwriteProjectId]"),
  // appwritePublicEndpoint("[appwriteProjectName]"),
  // appwriteDatabaseId("[appwriteDatabaseId]"),
  // appwriteFunctionEmployeeId("[appwriteFunctionEmployeeId]"),
  appwriteTableUsersId("users"),
  appwriteTableCompaniesId("companies"),
  appwriteTableShiftsId("shifts"),
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
