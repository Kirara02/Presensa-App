import 'package:flutter/material.dart';
import 'package:presensa_app/src/constants/navigation_bar_data.dart';

class EmployeeSmallScreenNavigationBar extends StatelessWidget {
  const EmployeeSmallScreenNavigationBar({
    super.key,
    required this.selectedScreen,
  });

  final String selectedScreen;

  NavigationDestination getNavigationDestination(
    BuildContext context,
    NavigationBarData data,
  ) {
    return NavigationDestination(
      icon: data.icon,
      label: data.label(context),
      selectedIcon: data.activeIcon,
      tooltip: data.label(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
      child: NavigationBar(
        selectedIndex: NavigationBarData.employeeIndexWherePathOrZero(
          selectedScreen,
        ),
        onDestinationSelected: (value) =>
            NavigationBarData.employeeNavList[value].go(context),
        destinations: NavigationBarData.employeeNavList
            .map<NavigationDestination>(
              (e) => getNavigationDestination(context, e),
            )
            .toList(),
      ),
    );
  }
}
