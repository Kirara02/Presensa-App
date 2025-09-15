// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_specify_types, public_member_api_docs

part of 'toast.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(toast)
const toastProvider = ToastFamily._();

final class ToastProvider extends $FunctionalProvider<Toast, Toast, Toast>
    with $Provider<Toast> {
  const ToastProvider._({
    required ToastFamily super.from,
    required BuildContext super.argument,
  }) : super(
         retry: null,
         name: r'toastProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$toastHash();

  @override
  String toString() {
    return r'toastProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Toast> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Toast create(Ref ref) {
    final argument = this.argument as BuildContext;
    return toast(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Toast value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Toast>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ToastProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$toastHash() => r'afa12e7c25e38923e8c1af465d21715175805653';

final class ToastFamily extends $Family
    with $FunctionalFamilyOverride<Toast, BuildContext> {
  const ToastFamily._()
    : super(
        retry: null,
        name: r'toastProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ToastProvider call(BuildContext context) =>
      ToastProvider._(argument: context, from: this);

  @override
  String toString() => r'toastProvider';
}
