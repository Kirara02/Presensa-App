part of '../router_config.dart';

@TypedShellRoute<AdminShellRoute>(
  routes: [
    TypedGoRoute<DashboardRoute>(path: '${Routes.admin}${Routes.dashboard}'),
    TypedGoRoute<EmployeesRoute>(path: '${Routes.admin}${Routes.users}'),
    TypedGoRoute<ReportsRoute>(path: '${Routes.admin}${Routes.reports}'),
    TypedGoRoute<AdminProfileRoute>(path: '${Routes.admin}${Routes.profile}'),
  ],
)
class AdminShellRoute extends ShellRouteData {
  const AdminShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey =
      _adminShellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return AdminShellScreen(child: navigator);
  }
}

class DashboardRoute extends GoRouteData with _$DashboardRoute {
  const DashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DashboardScreen();
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


class AdminProfileRoute extends GoRouteData with _$AdminProfileRoute {
  const AdminProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}

