import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/assets.dart';
import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../auth/presentation/controllers/auth/auth_controller.dart';
import '../../data/entities/ticket.dart';
import '../controllers/flight/flight_controller.dart';
import '../controllers/ticket/ticket_controller.dart';
import '../widgets/payment_form.dart';

class PaymentScreenArguments {
  final String seatId;
  final VoidCallback onCancel;

  const PaymentScreenArguments({
    required this.seatId,
    required this.onCancel,
  });
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.args});

  final PaymentScreenArguments args;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final user = context.watch<AuthController>().user;
  late final flight = context.watch<FlightController>().bookedFlight;
  late final ticket = Ticket(
    ticketId: '',
    seatId: widget.args.seatId,
    name: user.name,
    createdBy: user.uid,
    flight: flight,
  );

  double? discountedAmount;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.args.onCancel();
        return true;
      },
      child: Scaffold(
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
                PaymentForm(
                  amount: ticket.price,
                  onSubmit: onSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit() async {
    await context
        .read<TicketController>() //
        .generate(ticket)
        .then(
      (_) {
        context.pop();
        context.pop();
        context.replace(
          AppRoutes.boardingPass,
          arguments: ticket,
        );
      },
    );
  }
}
