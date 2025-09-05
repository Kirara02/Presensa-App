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

class EmployeeDetailRoute extends GoRouteData with _$EmployeeDetailRoute {
  final String id; // ID dari dokumen karyawan
  const EmployeeDetailRoute(this.id);

  @override
  Widget build(context, state) => EmployeeDetailScreen(employeeId: id);
}

class AddEmployeeRoute extends GoRouteData with _$AddEmployeeRoute {
  const AddEmployeeRoute();

  @override
  Widget build(context, state) => const AddEmployeeScreen();
}
