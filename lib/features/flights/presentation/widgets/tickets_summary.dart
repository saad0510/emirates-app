import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/extensions/text_ext.dart';
import '../../../common/presentation/widgets/ticket_widget.dart';
import '../../data/entities/ticket.dart';

class TicketsSummary extends StatelessWidget {
  const TicketsSummary({
    Key? key,
    required this.tickets,
  }) : super(key: key);

  final Iterable<Ticket> tickets;

  @override
  Widget build(BuildContext context) {
    double amount = 0.0;

    return TicketWidget(
      upper: Column(
        children: tickets.map(
          (ticket) {
            amount += ticket.price;
            return ListTile(
              contentPadding: AppPaddings.smallY,
              subtitle: Text(
                ticket.name,
                style: context.textTheme.headline5!.regular,
              ),
              minLeadingWidth: 60.w,
              leading: Text(
                ticket.seatId,
                style: context.textTheme.headline5!.regular,
              ),
              trailing: Text(
                '\$ ${ticket.price}',
                style: context.textTheme.headline5!.medium,
              ),
            );
          },
        ).toList(),
      ),
      lower: ListTile(
        subtitle: Text(
          "Total amount",
          style: context.textTheme.headline4!.medium,
        ),
        trailing: Text(
          '\$ $amount',
          style: context.textTheme.headline4!.medium,
        ),
      ),
    );
  }
}
