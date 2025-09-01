import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/core/providers/user_data_provider.dart';
import 'package:presensa_app/src/routes/router_config.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';
import 'package:presensa_app/src/widgets/shell/employee/employee_big_screen_navigation_bar.dart';
import 'package:presensa_app/src/widgets/shell/employee/employee_small_screen_navigation_bar.dart';

class EmployeeShellScreen extends ConsumerWidget {
  const EmployeeShellScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userDataProvider, (prev, next) {
      if (prev != null && next is AsyncData && next.value == null) {
        LoginRoute().go(context);
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });

    final location = context.location;

    if (context.isTablet) {
      return Scaffold(
        body: Row(
          children: [
            EmployeeBigScreenNavigationBar(selectedScreen: location),
            Expanded(child: child),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: child,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: EmployeeSmallScreenNavigationBar(
          selectedScreen: location,
        ),
      );
    }
  }
}
