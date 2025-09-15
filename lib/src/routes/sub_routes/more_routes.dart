part of '../router_config.dart';

class MoreBranch extends StatefulShellBranchData {
  static final $initialLocation = const MoreRoute().location;
  const MoreBranch();
}

class MoreRoute extends GoRouteData with $MoreRoute {
  const MoreRoute();
  @override
  Widget build(context, state) => MoreScreen();
}

class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}

class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}

class ChangePasswordRoute extends GoRouteData with $ChangePasswordRoute {
  const ChangePasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChangePasswordScreen();
}

class CompanyRoute extends GoRouteData with $CompanyRoute {
  const CompanyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CompanyScreen();
}

class ShiftsRoute extends GoRouteData with $ShiftsRoute {
  const ShiftsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ShiftsScreen();
}

class AboutRoute extends GoRouteData with $AboutRoute {
  const AboutRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AboutScreen();
}
