import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../../auth/presentation/controllers/auth/auth_controller.dart';
import '../../../flights/data/entities/city.dart';
import '../../../flights/presentation/controllers/city_controller.dart';
import '../widgets/destination_card.dart';

class WelcomeBody extends StatefulWidget {
  const WelcomeBody({super.key});

  @override
  State<WelcomeBody> createState() => _WelcomeBodyState();
}

class _WelcomeBodyState extends State<WelcomeBody> {
  List<Destination> dests = [];

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      context.read<CityController>().getPopularDestinations,
    ).then((x) => dests = x);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().user;
    final isLoading = context.watch<CityController>().state;

    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.normalX,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Hello! ${user.name}",
              style: context.textTheme.bodyText1?.colored,
            ),
            Text(
              "Where are you going?",
              style: context.textTheme.headline1,
            ),
            AppSizes.normalY,
            const Divider(),
            AppSizes.normalY,
            Text(
              "Popular Destinations",
              textAlign: TextAlign.center,
              style: context.textTheme.headline5!.medium,
            ),
            AppSizes.normalY,
            isLoading
                ? const Center(
                    heightFactor: 5,
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    width: context.width,
                    height: 400.h,
                    child: Swiper(
                      itemCount: dests.length,
                      autoplay: true,
                      autoplayDelay: 4000,
                      loop: true,
                      onIndexChanged: (i) {},
                      onTap: (i) {},
                      itemBuilder: (_, i) {
                        return Padding(
                          padding: AppPaddings.normalX,
                          child: DestinationCard(
                            city: dests[i].name,
                            country: dests[i].country,
                            rating: "4.8",
                            image: dests[i].image,
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
