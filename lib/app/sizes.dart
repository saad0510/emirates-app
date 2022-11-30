import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  static final smallY = SizedBox(height: 10.h);
  static final smallX = SizedBox(width: 10.w);

  static final normalY = SizedBox(height: 24.h);
  static final normalX = SizedBox(width: 20.w);

  static final maxY = SizedBox(height: 50.h);
}

class AppPaddings {
  static const zero = EdgeInsets.symmetric(vertical: 0, horizontal: 0);

  static final normal = EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w);

  static final extraSmallX = EdgeInsets.symmetric(horizontal: 5.w);
  static final smallX = EdgeInsets.symmetric(horizontal: 10.w);
  static final normalX = EdgeInsets.symmetric(horizontal: 16.w);

  static final smallY = EdgeInsets.symmetric(vertical: 10.h);
  static final normalY = EdgeInsets.symmetric(vertical: 16.h);
  static final largeY = EdgeInsets.symmetric(vertical: 30.h);

  static final smallXY = EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.w);
  static final normalXY = EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w);
}
