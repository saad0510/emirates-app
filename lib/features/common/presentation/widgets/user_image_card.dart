import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserImageCard extends StatelessWidget {
  const UserImageCard({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        "https://i.pravatar.cc/150?img=69",
        height: height ?? 40.h,
      ),
    );
  }
}
