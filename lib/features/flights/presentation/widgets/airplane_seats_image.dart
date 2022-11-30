import 'package:flutter/material.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../common/presentation/widgets/plane_clipper.dart';

class AirplaneSeatsImage extends StatelessWidget {
  const AirplaneSeatsImage({
    super.key,
    this.windowColor = Colors.white,
    required this.children,
  });

  final Color windowColor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipPath(
        clipper: PlaneClipper(),
        child: Container(
          margin: AppPaddings.normalX,
          padding: AppPaddings.smallX,
          color: context.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSizes.normalY,
              Image.asset(AppAssets.planeWindows, color: windowColor),
              AppSizes.normalY,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
