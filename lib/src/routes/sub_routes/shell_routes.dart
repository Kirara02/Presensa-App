part of '../router_config.dart';

@TypedStatefulShellRoute<ShellRoute>(
  branches: [
    TypedStatefulShellBranch<DashboardBranch>(
      routes: [TypedGoRoute<DashboardRoute>(path: Routes.dashboard)],
    ),
    TypedStatefulShellBranch<AttendanceBranch>(
      routes: [TypedGoRoute<AttendanceRoute>(path: Routes.attendance)],
    ),
    TypedStatefulShellBranch<EmployeesBranch>(
      routes: [
        TypedGoRoute<EmployeesRoute>(
          path: Routes.employees,
          routes: [
            TypedGoRoute<AddEmployeeRoute>(path: 'add'),
            TypedGoRoute<EmployeeDetailRoute>(path: ':id'),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<ReportsBranch>(
      routes: [TypedGoRoute<ReportsRoute>(path: Routes.reports)],
    ),
    TypedStatefulShellBranch<MoreBranch>(
      routes: [
        TypedGoRoute<MoreRoute>(
          path: Routes.more,
          routes: [
            TypedGoRoute<SettingsRoute>(path: Routes.settings),
            TypedGoRoute<ProfileRoute>(path: Routes.profile),
            TypedGoRoute<CompanyRoute>(path: Routes.company),
            TypedGoRoute<AboutRoute>(path: Routes.about),
          ],
        ),
      ],
    ),
  ],
)
class ShellRoute extends StatefulShellRouteData {
  const ShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    Widget navigationShell,
  ) {
    return ShellScreen(child: navigationShell);
  }
}
