import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../auth/presentation/widgets/auth_text_field.dart';

class RatingForm extends StatefulWidget {
  const RatingForm({super.key, required this.onSubmit});

  final void Function(int rating, String comment) onSubmit;

  @override
  State<RatingForm> createState() => _RatingFormState();
}

class _RatingFormState extends State<RatingForm> {
  int rating = 1;
  String comment = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Leave us a rating",
          textAlign: TextAlign.center,
          style: context.textTheme.headline3,
        ),
        AppSizes.normalY,
        Center(
          child: RatingBar.builder(
            minRating: 1,
            initialRating: 2,
            maxRating: 5,
            itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.orangeAccent),
            onRatingUpdate: (x) => rating = x.toInt(),
            glow: false,
            itemSize: 30,
          ),
        ),
        AppSizes.normalY,
        AuthTextField(
          label: "Comment",
          hint: "Any comment or suggestion?",
          onSubmit: (_) {},
          validator: (x) {
            comment = x ?? '';
            return null;
          },
        ),
        AppSizes.normalY,
        ElevatedButton(
          onPressed: () {
            widget.onSubmit(rating, comment);
            context.pop();
          },
          child: const Text("Submit"),
        ),
        AppSizes.normalY,
      ],
    );
  }
}
