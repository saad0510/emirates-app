import 'package:flutter/material.dart';

import '../../../../app/sizes.dart';
import '../../../../core/utils/date_time_service.dart';
import '../../../auth/presentation/widgets/auth_text_field.dart';
import '../../data/entities/credit_card_details.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({
    super.key,
    required this.amount,
    required this.onSubmit,
  });

  final double amount;
  final void Function(CreditCardDetails) onSubmit;

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final formKey = GlobalKey<FormState>();

  String cardNo = '', cvv = '';
  DateTime date = DateTimeService.minDate;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            label: "Card Number",
            hint: "XXXX - XXXX - XXXX - XXXX",
            keyboardType: TextInputType.number,
            onSubmit: (x) => cardNo = x,
          ),
          AppSizes.smallY,
          Row(
            children: [
              Expanded(
                flex: 2,
                child: AuthTextField(
                  label: "Expiry Date",
                  hint: "2024-12-06",
                  keyboardType: TextInputType.datetime,
                  onSubmit: (x) => x = x,
                ),
              ),
              AppSizes.normalX,
              Expanded(
                child: AuthTextField(
                  label: "CVV",
                  hint: "562",
                  keyboardType: TextInputType.number,
                  onSubmit: (x) => cvv = x,
                ),
              ),
            ],
          ),
          AppSizes.normalY,
          ElevatedButton(
            onPressed: submit,
            child: Text("Pay  \$${widget.amount}"),
          ),
        ],
      ),
    );
  }

  void submit() {
    if (!mounted) return;
    formKey.currentState!.save();
    widget.onSubmit(
      CreditCardDetails(
        cardNo: cardNo,
        expiryDate: date,
        cvv: cvv,
      ),
    );
  }
}
