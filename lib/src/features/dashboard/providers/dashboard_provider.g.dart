// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_specify_types, public_member_api_docs

part of 'dashboard_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardData)
const dashboardDataProvider = DashboardDataProvider._();

final class DashboardDataProvider
    extends $AsyncNotifierProvider<DashboardData, DashboardModel> {
  const DashboardDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardDataHash();

  @$internal
  @override
  DashboardData create() => DashboardData();
}

String _$dashboardDataHash() => r'58cfcf644cec07d8f1cca3569ab82a4212923c18';

abstract class _$DashboardData extends $AsyncNotifier<DashboardModel> {
  FutureOr<DashboardModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<DashboardModel>, DashboardModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DashboardModel>, DashboardModel>,
              AsyncValue<DashboardModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
