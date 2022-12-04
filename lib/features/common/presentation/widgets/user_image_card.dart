import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserImageCard extends StatelessWidget {
  const UserImageCard({super.key, this.height});

  static const imageUrl = "https://i.pravatar.cc/150?img=69";

  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        imageUrl,
        height: height ?? 40.h,
      ),
    );
  }
}
