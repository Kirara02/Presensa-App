import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presensa_app/src/features/attendance/presentation/attendance/attendance_screen.dart';
import 'package:presensa_app/src/features/auth/presentation/login/login_screen.dart';
import 'package:presensa_app/src/features/auth/presentation/register/register_screen.dart';
import 'package:presensa_app/src/features/auth/presentation/splash/splash_screen.dart';
import 'package:presensa_app/src/features/dashboard/presentation/dashboard/dashboard_screen.dart';
import 'package:presensa_app/src/features/employees/presentation/add_employee/add_employee_screen.dart';
import 'package:presensa_app/src/features/employees/presentation/employee_detail/employee_detail_screen.dart';
import 'package:presensa_app/src/features/employees/presentation/employees/employees_screen.dart';
import 'package:presensa_app/src/features/more/presentation/about/about_screen.dart';
import 'package:presensa_app/src/features/more/presentation/change_password/change_password_screen.dart';
import 'package:presensa_app/src/features/more/presentation/company/company_screen.dart';
import 'package:presensa_app/src/features/more/presentation/more/more_screen.dart';
import 'package:presensa_app/src/features/more/presentation/profile/profile_screen.dart';
import 'package:presensa_app/src/features/more/presentation/shifts/shifts_screen.dart';
import 'package:presensa_app/src/features/reports/presentation/reports/reports_screen.dart';
import 'package:presensa_app/src/features/more/presentation/settings/settings_screen.dart';
import 'package:presensa_app/src/widgets/shell/shell_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_config.g.dart';
part 'sub_routes/auth_routes.dart';
part 'sub_routes/shell_routes.dart';
part 'sub_routes/more_routes.dart';
part 'sub_routes/dashboard_routes.dart';
part 'sub_routes/attendance_routes.dart';
part 'sub_routes/employees_routes.dart';
part 'sub_routes/reports_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'admin shell',
);

abstract class Routes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';

  static const dashboard = '/dashboard';
  static const attendance = '/attendance';
  static const employees = '/employees';
  static const reports = '/reports';
  static const more = '/more';

  static const profile = 'profile';
  static const changePassword = 'change-pasword';
  static const company = 'company';
  static const shifts = 'shifts';
  static const about = 'about';
  static const settings = 'settings';
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
