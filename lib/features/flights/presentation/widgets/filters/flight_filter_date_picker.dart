import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/sizes.dart';
import '../../../../../core/extensions/context_ext.dart';
import '../../../../../core/utils/date_time_service.dart';

class FlightFilterDatePicker extends StatefulWidget {
  const FlightFilterDatePicker({super.key});

  @override
  State<FlightFilterDatePicker> createState() => _FlightFilterDatePickerState();
}

class _FlightFilterDatePickerState extends State<FlightFilterDatePicker> {
  DateTime from = DateTime.now();
  DateTime to = DateTimeService.maxDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _getLabel("From", context),
        InkWell(
          onTap: () => selectDateTime(context, isFrom: true),
          child: Text(
            DateTimeService.dateTimeStr(from, full: true),
            style: context.textTheme.headline4,
          ),
        ),
        AppSizes.smallY,
        _getLabel("To", context),
        InkWell(
          onTap: () => selectDateTime(context, isFrom: false),
          child: Text(
            DateTimeService.dateTimeStr(to, full: true),
            style: context.textTheme.headline4,
          ),
        ),
      ],
    );
  }

  void selectDateTime(BuildContext context, {required bool isFrom}) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 200.h,
          padding: AppPaddings.zero,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(22),
            ),
          ),
          child: CupertinoDatePicker(
            initialDateTime: isFrom ? from : to,
            minimumYear: isFrom ? 2000 : from.year,
            maximumYear: from.year,
            onDateTimeChanged: (x) {
              if (isFrom) {
                setState(() => from = x);
              } else {
                setState(() => to = x);
              }
            },
          ),
        );
      },
    );
  }

  Text _getLabel(String text, BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: context.textTheme.subtitle2,
    );
  }
}
