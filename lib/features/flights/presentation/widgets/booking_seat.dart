import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/assets.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../common/presentation/widgets/bottom_modal_sheet.dart';
import 'book_seat_dialog.dart';

class BookingSeat extends StatelessWidget {
  const BookingSeat({super.key, required this.occupied});

  final bool occupied;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !occupied
          ? null
          : () => BottomModalSheet.show(
                context,
                child: const BookSeatDialog(),
              ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          AppAssets.seat,
          width: 40.sp,
          fit: BoxFit.fitWidth,
          color: occupied ? context.primaryColor : null,
        ),
      ),
    );
  }
}
