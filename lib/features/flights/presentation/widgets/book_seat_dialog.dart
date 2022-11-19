import 'package:flutter/material.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';

class BookSeatDialog extends StatelessWidget {
  const BookSeatDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('CLASS'),
            Text('SEAT'),
            Text('PRICE'),
          ],
        ),
        DefaultTextStyle(
          style: context.textTheme.headline4!.medium,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Business'),
              Text('A2'),
              Text('\$5758.00'),
            ],
          ),
        ),
        AppSizes.normalY,
        ElevatedButton(
          onPressed: () {
            context.pop();
            context.push(AppRoutes.payment, arguments: 5758.0);
          },
          child: const Text("Confirm Seat"),
        ),
      ],
    );
  }
}
