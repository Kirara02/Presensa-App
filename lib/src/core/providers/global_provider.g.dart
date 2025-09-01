// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_specify_types, public_member_api_docs

part of 'global_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'91d3d8d16af3d747cec711b8a095a63e20df9b7c';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeProvider<SharedPreferences>.internal(
      sharedPreferences,
      name: r'sharedPreferencesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sharedPreferencesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = AutoDisposeProviderRef<SharedPreferences>;
String _$appDirectoryHash() => r'633687fc025026d147c4288ceac29f4ff82f9df9';

/// See also [appDirectory].
@ProviderFor(appDirectory)
final appDirectoryProvider = AutoDisposeProvider<Directory?>.internal(
  appDirectory,
  name: r'appDirectoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appDirectoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppDirectoryRef = AutoDisposeProviderRef<Directory?>;
String _$l10nHash() => r'c76dfb2d05d2abccdf86e36fe6b9e4f50ba4e49f';

/// See also [L10n].
@ProviderFor(L10n)
final l10nProvider = AutoDisposeNotifierProvider<L10n, Locale?>.internal(
  L10n.new,
  name: r'l10nProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$l10nHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$L10n = AutoDisposeNotifier<Locale?>;
String _$appwritePingHash() => r'eee63b1cd61a27f748d88e0d1d6e00d825e8f16d';

/// See also [AppwritePing].
@ProviderFor(AppwritePing)
final appwritePingProvider =
    AutoDisposeNotifierProvider<AppwritePing, bool?>.internal(
      AppwritePing.new,
      name: r'appwritePingProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appwritePingHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AppwritePing = AutoDisposeNotifier<bool?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
