import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:presensa_app/src/features/attendance/presentation/attendance/attendance_screen.dart';
import 'package:presensa_app/src/features/auth/presentation/login/login_screen.dart';
import 'package:presensa_app/src/features/auth/presentation/register/register_screen.dart';
import 'package:presensa_app/src/features/auth/presentation/splash/splash_screen.dart';
import 'package:presensa_app/src/features/dashboard/presentation/dashboard/dashboard_screen.dart';
import 'package:presensa_app/src/features/employees/presentation/employees/employees_screen.dart';
import 'package:presensa_app/src/features/profile/presentation/profile/profile_screen.dart';
import 'package:presensa_app/src/features/reports/presentation/reports/reports_screen.dart';
import 'package:presensa_app/src/features/settings/presentation/settings/settings_screen.dart';
import 'package:presensa_app/src/widgets/shell/admin/admin_shell_screen.dart';
import 'package:presensa_app/src/widgets/shell/employee/employee_shell_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_config.g.dart';
part 'sub_routes/auth_routes.dart';
part 'sub_routes/admin_routes.dart';
part 'sub_routes/employee_routes.dart';
part 'sub_routes/settings_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GlobalKey<NavigatorState> _adminShellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'admin shell');

final GlobalKey<NavigatorState> _employeeShellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'employee shell');

abstract class Routes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';

  static const admin = '/admin';
  static const employee = '/employee';

  static const dashboard = '/dashboard';
  static const attendance = '/attendance';
  static const users = '/users';
  static const reports = '/reports';
  static const profile = '/profile';

  static const settings = '/settings';
}

@riverpod
GoRouter routerConfig(Ref ref) {
  return GoRouter(
    routes: $appRoutes,
    debugLogDiagnostics: true,
    initialLocation: Routes.splash,
    navigatorKey: rootNavigatorKey,
  );
}
