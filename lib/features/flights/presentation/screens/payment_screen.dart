import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../common/presentation/widgets/bottom_modal_sheet.dart';
import '../../../common/presentation/widgets/secondary_button.dart';
import '../../../home/data/entities/notification_data.dart';
import '../../../home/presentation/controllers/notification_controller.dart';
import '../../data/entities/credit_card_details.dart';
import '../controllers/booking/booking_controller.dart';
import '../controllers/ticket/ticket_controller.dart';
import '../widgets/discount_sheet.dart';
import '../widgets/payment_form.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.controller});

  final BookingController controller;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  double? discountedAmount;
  bool loading = false;

  double get amount {
    return widget.controller.totalPrice - (discountedAmount ?? 0);
  }

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
                "Add your\nPayment Details",
                style: context.textTheme.headline1,
              ),
              AppSizes.normalY,
              Image.asset(AppAssets.creditCard),
              AppSizes.normalY,
              ...loading
                  ? [
                      const Center(
                        heightFactor: 5,
                        child: CircularProgressIndicator(),
                      ),
                    ]
                  : [
                      PaymentForm(
                        amount: amount,
                        onSubmit: onSubmit,
                      ),
                      AppSizes.smallY,
                      SecondaryButton(
                        onPressed: () {
                          BottomModalSheet.show(
                            context,
                            child: DiscountSheet(
                              onDiscounted: (x) {
                                setState(() => discountedAmount = x);
                              },
                            ),
                          );
                        },
                        child: discountedAmount != null //
                            ? const Text('XYZTYFS code applied')
                            : const Text("Use a Discount Code"),
                      ),
                    ],
            ],
          ),
        ),
      ),
    );
  }

  void onSubmit(CreditCardDetails details) async {
    setState(() => loading = true);
    final tickets = widget.controller.tickets;
    final scheduler = context.read<NotificationController>();
    final ticketController = context.read<TicketController>();

    List<Future<void>> tasks = [];

    for (final ticket in tickets) {
      tasks.add(
        ticketController.generate(ticket),
      );

      tasks.add(
        scheduler.scheduleNotification(
          NotificationData.fromTicket(ticket),
        ),
      );
    }

    await Future.wait(tasks);
    widget.controller.completeBooking();
    if (mounted) context.pop();
  }
}
