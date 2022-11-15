import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import 'destination_card.dart';

class PopularDestinationsShortList extends StatelessWidget {
  const PopularDestinationsShortList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, i) => AppSizes.normalX,
      itemBuilder: (_, i) => SizedBox(
        width: 250.sp,
        child: const DestinationCad(
          city: "Paris",
          country: "France",
          rating: "4.8",
          image: AppAssets.islandView,
        ),
      ),
    );
  }
}
