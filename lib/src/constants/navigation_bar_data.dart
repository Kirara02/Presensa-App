import 'package:flutter/material.dart';
import 'package:presensa_app/src/routes/router_config.dart';

class NavigationBarData {
  final String Function(BuildContext context) label;
  final ValueSetter<BuildContext> go;
  final Widget icon;
  final Widget activeIcon;
  final List<String> activeOn;

  static int adminIndexWherePathOrZero(String path) {
    final index = adminNavList.indexWhere(
      (e) => e.activeOn.any((element) => path.contains(element)),
    );
    return index > 0 ? index : 0;
  }

  static int employeeIndexWherePathOrZero(String path) {
    final index = employeeNavList.indexWhere(
      (e) => e.activeOn.any((element) => path.contains(element)),
    );
    return index > 0 ? index : 0;
  }

  static final adminNavList = [
    NavigationBarData(
      icon: Icon(Icons.space_dashboard_outlined),
      activeIcon: Icon(Icons.space_dashboard_rounded),
      label: (context) => "Dashboard",
      go: const DashboardRoute().go,
      activeOn: [const DashboardRoute().location],
    ),
    NavigationBarData(
      icon: Icon(Icons.people_outline_rounded),
      activeIcon: Icon(Icons.people_rounded),
      label: (context) => "Employees",
      go: const EmployeesRoute().go,
      activeOn: [const EmployeesRoute().location],
    ),
    NavigationBarData(
      icon: Icon(Icons.report_outlined),
      activeIcon: Icon(Icons.report_rounded),
      label: (context) => "Reports",
      go: const ReportsRoute().go,
      activeOn: [const ReportsRoute().location],
    ),
    NavigationBarData(
      icon: Icon(Icons.person_outline_rounded),
      activeIcon: Icon(Icons.person_rounded),
      label: (context) => "Profile",
      go: const AdminProfileRoute().go,
      activeOn: [const AdminProfileRoute().location],
    ),
  ];

  static final employeeNavList = [
    NavigationBarData(
      icon: Icon(Icons.space_dashboard_outlined),
      activeIcon: Icon(Icons.space_dashboard_rounded),
      label: (context) => "Attendance",
      go: const AttendanceRoute().go,
      activeOn: [const AttendanceRoute().location],
    ),
    NavigationBarData(
      icon: Icon(Icons.person_outline_rounded),
      activeIcon: Icon(Icons.person_rounded),
      label: (context) => "Profile",
      go: const EmployeeProfileRoute().go,
      activeOn: [const EmployeeProfileRoute().location],
    ),
  ];

  NavigationBarData({
    required this.label,
    required this.go,
    required this.icon,
    required this.activeIcon,
    required this.activeOn,
  });
}
