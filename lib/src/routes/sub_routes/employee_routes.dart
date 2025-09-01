part of '../router_config.dart';

@TypedShellRoute<EmployeeShellRoute>(
  routes: [
    TypedGoRoute<AttendanceRoute>(
      path: '${Routes.employee}${Routes.attendance}',
    ),
    TypedGoRoute<EmployeeProfileRoute>(
      path: '${Routes.employee}${Routes.profile}',
    ),
  ],
)
class EmployeeShellRoute extends ShellRouteData {
  const EmployeeShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey =
      _employeeShellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return EmployeeShellScreen(child: navigator);
  }
}

class AttendanceRoute extends GoRouteData with _$AttendanceRoute {
  const AttendanceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AttendanceScreen();
}

class EmployeeProfileRoute extends GoRouteData with _$EmployeeProfileRoute {
  const EmployeeProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}
