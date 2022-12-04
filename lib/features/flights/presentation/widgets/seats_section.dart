import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../../common/presentation/widgets/bottom_modal_sheet.dart';
import '../../data/entities/flight_class.dart';
import '../controllers/seats/seat_widget.dart';
import '../controllers/seats/seats_controller.dart';
import 'confirm_seat_dialog.dart';

class SeatsSection extends StatelessWidget {
  const SeatsSection({
    super.key,
    required this.rowsNo,
    required this.rowSize,
    required this.price,
    required this.flightClass,
    required this.onConfirm,
  });

  final int rowSize;
  final int rowsNo;
  final double price;
  final FlightClass flightClass;
  final void Function(String seatId) onConfirm;

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
              (col) => Expanded(
                child: SeatWidget(
                  seatId: getId(row, col),
                  onSelected: (sid) => showSeatDialog(sid, context),
                ),
              ),
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
          await context.read<SeatsController>().reserve(sid);
          onConfirm(sid);
        },
      ),
    );
  }

  String getId(int row, int col) {
    final c = String.fromCharCode(col % rowSize + 65);
    return '${flightClass.prefix}$c${row + 1}';
  }
}
