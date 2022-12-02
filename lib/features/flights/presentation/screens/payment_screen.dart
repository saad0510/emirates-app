import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/assets.dart';
import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../auth/presentation/controllers/auth/auth_controller.dart';
import '../../data/entities/flight_class.dart';
import '../../data/entities/ticket.dart';
import '../controllers/flight/flight_controller.dart';
import '../controllers/ticket/ticket_controller.dart';
import '../widgets/payment_form.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.seatId});

  final String seatId;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final flightClass = FlightClass.fromId(widget.seatId);
  late final flight = context.watch<FlightController>().bookedFlight;
  late final price = flightClass == FlightClass.business //
      ? flight.businesCost
      : flight.economyCost;

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
              PaymentForm(
                amount: price,
                onSubmit: () async {
                  final user = context.read<AuthController>().user;

                  await context
                      .read<TicketController>()
                      .generate(
                        Ticket(
                          flightId: flight.fid,
                          seatId: widget.seatId,
                          name: user.name,
                          createdBy: user.uid,
                          flightClass: flightClass,
                        ),
                      )
                      .then(
                    (_) {
                      context.pop();
                      context.pop();
                      context.replace(AppRoutes.boardingPass);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
