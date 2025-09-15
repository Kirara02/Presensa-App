// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_specify_types, public_member_api_docs

part of 'shift_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShiftList)
const shiftListProvider = ShiftListProvider._();

final class ShiftListProvider
    extends $AsyncNotifierProvider<ShiftList, List<Shift>> {
  const ShiftListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shiftListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shiftListHash();

  @$internal
  @override
  ShiftList create() => ShiftList();
}

String _$shiftListHash() => r'63b1609a1454b17a5d1676d25ad7edf013f70c95';

abstract class _$ShiftList extends $AsyncNotifier<List<Shift>> {
  FutureOr<List<Shift>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Shift>>, List<Shift>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Shift>>, List<Shift>>,
              AsyncValue<List<Shift>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
