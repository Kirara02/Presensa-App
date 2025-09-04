part of '../router_config.dart';

@TypedShellRoute<ShellRoute>(
  routes: [
    TypedGoRoute<DashboardRoute>(path: Routes.dashboard),
    TypedGoRoute<AttendanceRoute>(path: Routes.attendance),
    TypedGoRoute<EmployeesRoute>(path: Routes.employees),
    TypedGoRoute<ReportsRoute>(path: Routes.reports),
    TypedGoRoute<MoreRoute>(path: Routes.more),
  ],
)
class ShellRoute extends ShellRouteData {
  const ShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return ShellScreen(child: navigator);
  }
}

class DashboardRoute extends GoRouteData with _$DashboardRoute {
  const DashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DashboardScreen();
}

class AttendanceRoute extends GoRouteData with _$AttendanceRoute {
  const AttendanceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AttendanceScreen();
}

class EmployeesRoute extends GoRouteData with _$EmployeesRoute {
  const EmployeesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EmployeesScreen();
}

class ReportsRoute extends GoRouteData with _$ReportsRoute {
  const ReportsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ReportsScreen();
}

class MoreRoute extends GoRouteData with _$MoreRoute {
  const MoreRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const MoreScreen();
}
