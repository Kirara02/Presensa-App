import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:presensa_app/src/core/providers/user_data_provider.dart';
import 'package:presensa_app/src/routes/router_config.dart';
import 'package:presensa_app/src/utils/extensions/custom_extensions.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userDataProvider, (prev, next) {
      if (next.isLoading) return;

      if (next is AsyncData) {
        if (next.value != null) {
          if (next.value!.isAdmin) {
            DashboardRoute().go(context);
          } else {
            AttendanceRoute().go(context);
          }
        } else {
          const LoginRoute().go(context);
        }
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });
    return const Scaffold(body: Center(child: Text('Splash Screen')));
  }
}
