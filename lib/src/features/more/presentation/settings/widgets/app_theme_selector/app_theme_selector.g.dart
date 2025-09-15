// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_specify_types, public_member_api_docs

part of 'app_theme_selector.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppScheme)
const appSchemeProvider = AppSchemeProvider._();

final class AppSchemeProvider
    extends $NotifierProvider<AppScheme, FlexScheme?> {
  const AppSchemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appSchemeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appSchemeHash();

  @$internal
  @override
  AppScheme create() => AppScheme();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlexScheme? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlexScheme?>(value),
    );
  }
}

String _$appSchemeHash() => r'8cd845a42d472479542f20e5f377624ac4d1f937';

abstract class _$AppScheme extends $Notifier<FlexScheme?> {
  FlexScheme? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FlexScheme?, FlexScheme?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FlexScheme?, FlexScheme?>,
              FlexScheme?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
