import 'package:flutter/material.dart';
import 'package:presensa_app/src/constants/navigation_bar_data.dart';

class SmallScreenNavigationBar extends StatelessWidget {
  const SmallScreenNavigationBar({
    super.key,
    required this.selectedScreen,
    required this.navList, // 1. TAMBAHKAN INI
  });

  final String selectedScreen;
  final List<NavigationBarData> navList; // 2. TAMBAHKAN PROPERTI INI

  NavigationDestination getNavigationDestination(
    BuildContext context,
    NavigationBarData data,
  ) {
    // ... (tidak ada perubahan di fungsi ini)
    return NavigationDestination(
      icon: data.icon,
      label: data.label(context),
      selectedIcon: data.activeIcon,
      tooltip: data.label(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Safety check: Jika tidak ada item navigasi, jangan tampilkan apa-apa
    if (navList.isEmpty) {
      return const SizedBox.shrink();
    }

    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
      child: NavigationBar(
        // 3. GUNAKAN navList DARI PARAMETER
        selectedIndex: NavigationBarData.indexWherePathOrZero(
          selectedScreen,
          navList,
        ),
        onDestinationSelected: (value) => navList[value].go(context),
        destinations: navList
            .map<NavigationDestination>(
              (e) => getNavigationDestination(context, e),
            )
            .toList(),
      ),
    );
  }
}
