import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';

class BookingTripTypeSelector extends StatefulWidget {
  const BookingTripTypeSelector({super.key});

  @override
  State<BookingTripTypeSelector> createState() => _BookingTripTypeSelectorState();
}

class _BookingTripTypeSelectorState extends State<BookingTripTypeSelector> {
  int selected = 0;

  final types = ['One Way', 'Round Trip'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        types.length,
        (i) => GestureDetector(
          onTap: () => setState(() => selected = i),
          child: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(padding: AppPaddings.normalX),
              onPressed: selected == i ? () {} : null,
              child: Text(types[i]),
            ),
          ),
        ),
      ),
    );
  }
}
