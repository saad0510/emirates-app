import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import 'destination_card.dart';

class PopularDestinationsList extends StatelessWidget {
  const PopularDestinationsList({super.key, this.gridView = false});

  final bool gridView;

  @override
  Widget build(BuildContext context) {
    const destination = DestinationCad(
      city: "Paris",
      country: "France",
      rating: "4.8",
      image: AppAssets.islandView,
    );

    return !gridView
        ? ListView.separated(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, i) => AppSizes.normalX,
            itemBuilder: (_, i) => SizedBox(width: 250.sp, child: destination),
          )
        : GridView.builder(
            itemCount: 5,
            itemBuilder: (_, i) => destination,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.75,
              crossAxisSpacing: 10.sp,
              mainAxisSpacing: 10.sp,
            ),
          );
  }
}
