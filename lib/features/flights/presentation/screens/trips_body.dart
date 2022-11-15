import 'package:flutter/material.dart';

import '../../../../app/sizes.dart';

class TripsBody extends StatelessWidget {
  const TripsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.normalX,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text("Not implemented"),
          ],
        ),
      ),
    );
  }
}
