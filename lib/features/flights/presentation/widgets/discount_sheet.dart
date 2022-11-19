import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../auth/presentation/widgets/auth_text_field.dart';

class DiscountSheet extends StatefulWidget {
  const DiscountSheet({super.key});

  @override
  State<DiscountSheet> createState() => _DiscountSheetState();
}

class _DiscountSheetState extends State<DiscountSheet> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(
          flex: 5,
          child: AuthTextField(
            label: "Dicount Code",
            hint: 'XXXX',
            keyboardType: TextInputType.number,
          ),
        ),
        AppSizes.smallX,
        Expanded(
          child: loading
              ? Container(
                  height: 40.h,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )
              : IconButton(
                  onPressed: () => submit(),
                  icon: const Icon(Icons.check),
                ),
        ),
      ],
    );
  }

  void submit() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) context.pop();
  }
}
