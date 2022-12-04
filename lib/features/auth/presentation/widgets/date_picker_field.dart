import 'package:flutter/material.dart';

import '../../../../core/utils/date_time_service.dart';
import 'auth_text_field.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({
    super.key,
    required this.onChanged,
    required this.controller,
    required this.title,
  });

  final String title;
  final void Function(DateTime) onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextButtonTheme(
      data: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
        ),
      ),
      child: Builder(
        builder: (context) => InkWell(
          onTap: () async {
            final now = DateTime.now();

            final d = await showDatePicker(
              context: context,
              initialDate: now,
              firstDate: DateTimeService.minDate,
              lastDate: DateTimeService.maxDate,
            );
            if (d != null) {
              onChanged(d);
              controller.text = '${d.year}-${d.month}-${d.day}';
            }
          },
          child: AbsorbPointer(
            absorbing: true,
            child: AuthTextField(
              label: title,
              hint: "1999-02-28",
              onSubmit: (x) {},
              keyboardType: TextInputType.none,
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }
}
