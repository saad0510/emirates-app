import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_ext.dart';

class TextActionButton extends StatelessWidget {
  const TextActionButton({
    super.key,
    this.leading = "",
    required this.highlight,
    this.underline = true,
    required this.onPressed,
  });

  final String leading;
  final String highlight;
  final bool underline;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: leading,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w300,
              color: context.contrastColor,
            ),
          ),
          TextSpan(
            text: highlight,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              decoration: underline ? TextDecoration.underline : null,
              color: context.primaryColor,
            ),
          ),
        ]),
      ),
    );
  }
}
