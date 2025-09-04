import 'package:flutter/material.dart';
import 'package:presensa_app/src/constants/gen/assets.gen.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Assets.icons.presensaIcon.svg(width: 120, height: 120);
  }
}
