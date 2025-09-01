part of '../router_config.dart';

@TypedGoRoute<SettingsRoute>(path: Routes.settings)
class SettingsRoute extends GoRouteData with _$SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}
