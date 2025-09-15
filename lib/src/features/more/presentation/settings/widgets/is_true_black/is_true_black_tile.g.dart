// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_specify_types, public_member_api_docs

part of 'is_true_black_tile.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IsTrueBlack)
const isTrueBlackProvider = IsTrueBlackProvider._();

final class IsTrueBlackProvider extends $NotifierProvider<IsTrueBlack, bool?> {
  const IsTrueBlackProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isTrueBlackProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isTrueBlackHash();

  @$internal
  @override
  IsTrueBlack create() => IsTrueBlack();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool?>(value),
    );
  }
}

String _$isTrueBlackHash() => r'7d06357ad040ecc24d9729c2b3fa4419bd573487';

abstract class _$IsTrueBlack extends $Notifier<bool?> {
  bool? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool?, bool?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool?, bool?>,
              bool?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
