import 'package:flutter/material.dart';
import 'package:presensa_app/src/constants/navigation_bar_data.dart';
// import 'package:presensa_app/src/features/auth/presentation/widgets/app_logo.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';

class AdminBigScreenNavigationBar extends StatelessWidget {
  const AdminBigScreenNavigationBar({super.key, required this.selectedScreen});

  final String selectedScreen;

  NavigationRailDestination getNavigationRailDestination(
    BuildContext context,
    NavigationBarData data,
  ) {
    return NavigationRailDestination(
      icon: data.icon,
      label: Text(data.label(context)),
      selectedIcon: data.activeIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget leadingIcon = SizedBox.shrink();
    if (context.isDesktop) {
      // leadingIcon = AppLogo();
    } else {
      // leadingIcon = AppLogo();
    }

    return NavigationRail(
      useIndicator: true,
      elevation: 5,
      extended: context.isDesktop,
      labelType: context.isDesktop
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.all,
      leading: leadingIcon,
      destinations: NavigationBarData.adminNavList
          .map<NavigationRailDestination>(
            (e) => getNavigationRailDestination(context, e),
          )
          .toList(),
      selectedIndex: NavigationBarData.adminIndexWherePathOrZero(selectedScreen),
      onDestinationSelected: (value) =>
          NavigationBarData.adminNavList[value].go(context),
    );
  }
}
