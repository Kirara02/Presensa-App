import 'package:flutter/material.dart';
import 'package:presensa_app/src/constants/navigation_bar_data.dart';
// import 'package:presensa_app/src/features/auth/presentation/widgets/app_logo.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';

class BigScreenNavigationBar extends StatelessWidget {
  const BigScreenNavigationBar({
    super.key,
    required this.selectedScreen,
    required this.navList,
  });

  final String selectedScreen;
  final List<NavigationBarData> navList;

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
    if (navList.isEmpty) {
      return const SizedBox.shrink();
    }

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
      // 3. GUNAKAN navList DARI PARAMETER
      destinations: navList
          .map<NavigationRailDestination>(
            (e) => getNavigationRailDestination(context, e),
          )
          .toList(),
      selectedIndex: NavigationBarData.indexWherePathOrZero(
        selectedScreen,
        navList,
      ),
      onDestinationSelected: (value) => navList[value].go(context),
    );
  }
}
