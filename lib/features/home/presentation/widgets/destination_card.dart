import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';

class DestinationCard extends StatelessWidget {
  const DestinationCard({
    super.key,
    required this.city,
    required this.country,
    required this.rating,
    required this.image,
  });

  final String city;
  final String country;
  final String rating;
  final String image;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);

    return Container(
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Image.network(image, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  city,
                  style: context.textTheme.headline4?.medium,
                ),
                AppSizes.smallY,
                DefaultTextStyle(
                  style: context.textTheme.subtitle2!.copyWith(color: BlackColor.light),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(Icons.location_on_outlined, size: 18),
                      Text(country),
                      const Spacer(),
                      const Icon(Icons.star_rounded, size: 18, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(rating),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
