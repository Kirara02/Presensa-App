part of '../router_config.dart';

class EmployeesBranch extends StatefulShellBranchData {
  static final $initialLocation = const EmployeesRoute().location;
  const EmployeesBranch();
}

class EmployeesRoute extends GoRouteData with _$EmployeesRoute {
  const EmployeesRoute();
  @override
  Widget build(context, state) => EmployeesScreen();
}