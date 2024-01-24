import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MySvgWidget extends StatelessWidget {
  final String svgPath;
  final String svgLabel;

  const MySvgWidget({super.key, required this.svgPath, required this.svgLabel});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(svgPath,
        semanticsLabel: svgLabel,
        colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.inverseSurface, BlendMode.srcIn));
  }
}
