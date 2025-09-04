import 'package:flutter/material.dart';
import 'package:presensa_app/src/routes/router_config.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';

class NavigationBarData {
  final String Function(BuildContext context) label;
  final ValueSetter<BuildContext> go;
  final Widget icon;
  final Widget activeIcon;
  final List<String> activeOn;

  static final List<NavigationBarData> _adminNavList = [
    NavigationBarData(
      icon: Icon(Icons.space_dashboard_outlined),
      activeIcon: Icon(Icons.space_dashboard_rounded),
      label: (context) => context.l10n!.dashboard,
      go: const DashboardRoute().go,
      activeOn: [const DashboardRoute().location],
    ),
    NavigationBarData(
      icon: Icon(Icons.people_outline_rounded),
      activeIcon: Icon(Icons.people_rounded),
      label: (context) => context.l10n!.employees,
      go: const EmployeesRoute().go,
      activeOn: [const EmployeesRoute().location],
    ),
    NavigationBarData(
      icon: Icon(Icons.report_outlined),
      activeIcon: Icon(Icons.report_rounded),
      label: (context) => context.l10n!.reports,
      go: const ReportsRoute().go,
      activeOn: [const ReportsRoute().location],
    ),
    NavigationBarData(
      icon: Icon(Icons.more_horiz_outlined),
      activeIcon: Icon(Icons.more_horiz_rounded),
      label: (context) => context.l10n!.more,
      go: const MoreRoute().go,
      activeOn: [const MoreRoute().location, SettingsRoute().location],
    ),
  ];

  static final List<NavigationBarData> _employeeNavList = [
    NavigationBarData(
      icon: Icon(Icons.space_dashboard_outlined),
      activeIcon: Icon(Icons.space_dashboard_rounded),
      label: (context) => context.l10n!.attendance,
      go: const AttendanceRoute().go,
      activeOn: [const AttendanceRoute().location],
    ),
    NavigationBarData(
      icon: Icon(Icons.more_horiz_outlined),
      activeIcon: Icon(Icons.more_horiz_rounded),
      label: (context) => context.l10n!.more,
      go: const MoreRoute().go,
      activeOn: [const MoreRoute().location, SettingsRoute().location],
    ),
  ];

  static List<NavigationBarData> getNavListForRole(String? role) {
    switch (role?.toLowerCase()) {
      case 'admin':
        return _adminNavList;
      case 'employee':
        return _employeeNavList;
      default:
        return [];
    }
  }

  static int indexWherePathOrZero(
    String path,
    List<NavigationBarData> navList,
  ) {
    if (navList.isEmpty) return 0;
    final index = navList.indexWhere(
      (e) => e.activeOn.any((element) => path.contains(element)),
    );
    return index == -1 ? 0 : index;
  }

  NavigationBarData({
    required this.label,
    required this.go,
    required this.icon,
    required this.activeIcon,
    required this.activeOn,
  });
}
