import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/core/providers/user_data_provider.dart';
import 'package:presensa_app/src/routes/router_config.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';
import 'package:presensa_app/src/widgets/shell/admin/admin_big_screen_navigation_bar.dart';
import 'package:presensa_app/src/widgets/shell/admin/admin_small_screen_navigation_bar.dart';

class AdminShellScreen extends ConsumerWidget {
  const AdminShellScreen({super.key, required this.child});
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
            AdminBigScreenNavigationBar(selectedScreen: location),
            Expanded(child: child),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: child,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: AdminSmallScreenNavigationBar(
          selectedScreen: location,
        ),
      );
    }
  }
}
