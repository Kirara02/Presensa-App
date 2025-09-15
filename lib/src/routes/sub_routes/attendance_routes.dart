part of '../router_config.dart';

class AttendanceBranch extends StatefulShellBranchData {
  static final $initialLocation = const AttendanceRoute().location;
  const AttendanceBranch();
}

class AttendanceRoute extends GoRouteData with $AttendanceRoute {
  const AttendanceRoute();
  @override
  Widget build(context, state) => AttendanceScreen();
}