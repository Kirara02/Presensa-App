// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_specify_types, public_member_api_docs

part of 'company_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CompanyData)
const companyDataProvider = CompanyDataProvider._();

final class CompanyDataProvider
    extends $AsyncNotifierProvider<CompanyData, Company?> {
  const CompanyDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'companyDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$companyDataHash();

  @$internal
  @override
  CompanyData create() => CompanyData();
}

String _$companyDataHash() => r'e8542f0d9d5298e57958f977094b2019940cc469';

abstract class _$CompanyData extends $AsyncNotifier<Company?> {
  FutureOr<Company?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Company?>, Company?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Company?>, Company?>,
              AsyncValue<Company?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
