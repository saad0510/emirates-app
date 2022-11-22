import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../auth/presentation/widgets/auth_text_field.dart';
import '../../../common/presentation/widgets/bottom_modal_sheet.dart';
import '../../../common/presentation/widgets/secondary_button.dart';
import '../../data/entities/flight.dart';
import '../../data/entities/flight_class.dart';
import '../controllers/city_controller.dart';
import 'discount_sheet.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key, required this.amount});

  final double amount;

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  double? discountedAmount;
  final formKey = GlobalKey<FormState>();

  double get payAmount => widget.amount - (discountedAmount ?? 0);

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
            onSubmit: (x) => x = x,
          ),
          AppSizes.smallY,
          Row(
            children: [
              Expanded(
                flex: 2,
                child: AuthTextField(
                  label: "Expiry Date",
                  hint: "12-06-2024",
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
                  onSubmit: (x) => x = x,
                ),
              ),
            ],
          ),
          AppSizes.normalY,
          ElevatedButton(
            onPressed: submit,
            child: Text("Pay  \$${payAmount.toStringAsFixed(2)}"),
          ),
          AppSizes.smallY,
          SecondaryButton(
            onPressed: () {
              if (discountedAmount != null) return;
              BottomModalSheet.show(
                context,
                child: Container(
                  height: 330.h,
                  alignment: Alignment.topCenter,
                  child: const DiscountSheet(),
                ),
              );
              setState(() => discountedAmount = 500);
            },
            child: discountedAmount != null //
                ? const Text('XYZTYFS code applied')
                : const Text("Use a Discount Code"),
          ),
        ],
      ),
    );
  }

  void submit() {
    final flight = Flight(
      fid: "AB689",
      departureCity: CityController.cities.first,
      arrivalCity: CityController.cities.last,
      dateTime: DateTime.now(),
      cost: 500,
      flightClass: FlightClass.business,
    );
    context.pop();
    context.pop();
    context.pop();
    context.push(AppRoutes.boardingPass, arguments: flight);
  }
}
