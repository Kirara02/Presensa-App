part of '../router_config.dart';

class ReportsBranch extends StatefulShellBranchData {
  static final $initialLocation = const ReportsRoute().location;
  const ReportsBranch();
}

class ReportsRoute extends GoRouteData with _$ReportsRoute {
  const ReportsRoute();
  @override
  Widget build(context, state) => ReportsScreen();
}