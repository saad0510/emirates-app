import 'package:flutter/material.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../widgets/payment_form.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.amount});

  final double amount;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  double? discountedAmount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.normalXY,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Add your\npayment details",
                style: context.textTheme.headline1,
              ),
              AppSizes.normalY,
              Image.asset(AppAssets.creditCard),
              AppSizes.normalY,
              PaymentForm(amount: widget.amount),
            ],
          ),
        ),
      ),
    );
  }
}
