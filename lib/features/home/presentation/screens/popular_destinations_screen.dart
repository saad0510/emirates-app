import 'package:flutter/material.dart';

import '../../../../app/sizes.dart';
import '../widgets/popular_destinations_list.dart';

class PopularDestinationsScreen extends StatelessWidget {
  const PopularDestinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Destinations"),
      ),
      body: Padding(
        padding: AppPaddings.smallXY,
        child: const PopularDestinationsList(gridView: true),
      ),
    );
  }
}
