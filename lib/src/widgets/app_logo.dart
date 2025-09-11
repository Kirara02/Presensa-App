import 'package:flutter/material.dart';
import 'package:presensa_app/src/constants/gen/assets.gen.dart';

class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  const AppLogo({super.key, this.width = 150, this.height = 150});

  @override
  Widget build(BuildContext context) {
    return Assets.icons.presensaIcon.svg(width: width, height: height);
  }
}
