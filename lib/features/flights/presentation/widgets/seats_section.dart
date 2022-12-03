import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/routes.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../../common/presentation/widgets/bottom_modal_sheet.dart';
import '../../data/entities/flight_class.dart';
import '../controllers/seats/seat_widget.dart';
import '../controllers/seats/seats_controller.dart';
import '../screens/payment_screen.dart';
import 'confirm_seat_dialog.dart';

class SeatsSection extends StatelessWidget {
  const SeatsSection({
    super.key,
    required this.rowsNo,
    required this.rowSize,
    required this.price,
    required this.flightClass,
  });

  final int rowSize;
  final int rowsNo;
  final double price;
  final FlightClass flightClass;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${flightClass.name} class',
          textAlign: TextAlign.center,
          style: context.textTheme.subtitle2,
        ),
        AppSizes.normalY,
        ...List.generate(
          rowsNo,
          (row) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              rowSize,
              (col) {
                final sid = getId(row, col);

                return Expanded(
                  child: SeatWidget(
                    seatId: sid,
                    onSelected: (sid) => showSeatDialog(sid, context),
                  ),
                );
              },
            )..insert(
                rowSize ~/ 2,
                Expanded(
                  flex: 2,
                  child: Text(
                    '${row + 1}',
                    style: context.textTheme.subtitle2!.bold,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ),
        ),
      ],
    );
  }

  void showSeatDialog(String sid, BuildContext context) {
    BottomModalSheet.show(
      context,
      child: ConfirmSeatDialog(
        seatId: sid,
        price: price,
        flightClass: flightClass,
        onConfirm: () async {
          final controller = context.read<SeatsController>();

          await controller.reserve(sid).then(
            (_) {
              final args = PaymentScreenArguments(
                seatId: sid,
                onCancel: () => controller.cancel(sid),
              );

              return context.push(AppRoutes.payment, arguments: args);
            },
          );
        },
      ),
    );
  }

  String getId(int row, int col) {
    final c = String.fromCharCode(col % rowSize + 65);
    return '${flightClass.prefix}$c${row + 1}';
  }
}
