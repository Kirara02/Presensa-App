import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/constants/db_keys.dart';
import 'package:presensa_app/src/core/mixin/shared_preferences_client_mixin.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'global_provider.g.dart';

@riverpod
class L10n extends _$L10n with SharedPreferenceClientMixin<Locale> {
  Map<String, String> toJson(Locale locale) => {
    if (locale.countryCode.isNotBlank) "countryCode": locale.countryCode!,
    if (locale.languageCode.isNotBlank) "languageCode": locale.languageCode,
    if (locale.scriptCode.isNotBlank) "scriptCode": locale.scriptCode!,
  };
  Locale? fromJson(dynamic json) =>
      json is! Map<String, dynamic> || (json["languageCode"] == null)
      ? null
      : Locale.fromSubtags(
          languageCode: json["languageCode"]!.toString(),
          scriptCode: json["scriptCode"]?.toString(),
          countryCode: json["countryCode"]?.toString(),
        );

  @override
  Locale? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final initial = initialize(
      prefs,
      DBKeys.l10n,
      fromJson: fromJson,
      toJson: toJson,
    );

    listenSelf((prev, next) {
      persist(next);
    });

    return initial;
  }
}

@riverpod
class AppwritePing extends _$AppwritePing
    with SharedPreferenceClientMixin<bool> {
  @override
  bool? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final initial = initialize(prefs, DBKeys.appwritePing);

    listenSelf((prev, next) {
      persist(next);
    });

    return initial;
  }
}

@riverpod
SharedPreferences sharedPreferences(Ref ref) => throw UnimplementedError();

@riverpod
Directory? appDirectory(Ref ref) => throw UnimplementedError();
