import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';

class ChipSelector extends StatefulWidget {
  const ChipSelector({
    super.key,
    required this.values,
    required this.onChanged,
  });

  final List<String> values;
  final void Function(int index) onChanged;

  @override
  State<ChipSelector> createState() => _ChipSelectorState();
}

class _ChipSelectorState extends State<ChipSelector> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.values.length,
        (i) => GestureDetector(
          onTap: () {
            if (selected == i) return;
            setState(() => selected = i);
            widget.onChanged(i);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(padding: AppPaddings.normalX),
              onPressed: selected == i ? () {} : null,
              child: Text(widget.values[i]),
            ),
          ),
        ),
      ),
    );
  }
}
