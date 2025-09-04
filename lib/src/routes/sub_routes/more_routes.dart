part of '../router_config.dart';

class MoreBranch extends StatefulShellBranchData {
  static final $initialLocation = const MoreRoute().location;
  const MoreBranch();
}

class MoreRoute extends GoRouteData with _$MoreRoute {
  const MoreRoute();
  @override
  Widget build(context, state) => MoreScreen();
}

class SettingsRoute extends GoRouteData with _$SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}

class ProfileRoute extends GoRouteData with _$ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}


class CompanyRoute extends GoRouteData with _$CompanyRoute {
  const CompanyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CompanyScreen();
}

class AboutRoute extends GoRouteData with _$AboutRoute {
  const AboutRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AboutScreen();
}