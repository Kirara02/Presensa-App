// Copyright (c) 2022 Contributors to the Suwayomi project
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/constants/db_keys.dart';
import 'package:presensa_app/src/core/mixin/shared_preferences_client_mixin.dart';
import 'package:presensa_app/src/core/providers/global_provider.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_true_black_tile.g.dart';

@riverpod
class IsTrueBlack extends _$IsTrueBlack with SharedPreferenceClientMixin<bool> {
  @override
  bool? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final initial = initialize(prefs, DBKeys.isTrueBlack);

    listenSelf((prev, next) {
      persist(next);
    });

    return initial;
  }
}

class IsTrueBlackTile extends ConsumerWidget {
  const IsTrueBlackTile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
      controlAffinity: ListTileControlAffinity.trailing,
      secondary: const Icon(Icons.circle, color: Colors.black),
      title: Text(context.l10n!.is_true_black),
      onChanged: ref.read(isTrueBlackProvider.notifier).update,
      value: ref.watch(isTrueBlackProvider).ifNull(),
    );
  }
}
