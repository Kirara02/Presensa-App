part of '../router_config.dart';

class DashboardBranch extends StatefulShellBranchData {
  static final $initialLocation = const DashboardRoute().location;
  const DashboardBranch();
}

class DashboardRoute extends GoRouteData with _$DashboardRoute {
  const DashboardRoute();
  @override
  Widget build(context, state) => DashboardScreen();
}