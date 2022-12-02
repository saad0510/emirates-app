import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../controllers/flight/flight_controller.dart';
import '../controllers/pdf_controller.dart';
import '../controllers/ticket/ticket_controller.dart';
import '../widgets/boarding_pass_card.dart';

class BoardingPassScreen extends StatefulWidget {
  const BoardingPassScreen({super.key});

  @override
  State<BoardingPassScreen> createState() => _BoardingPassScreenState();
}

class _BoardingPassScreenState extends State<BoardingPassScreen> {
  String? path;

  late final ticket = context.watch<TicketController>().bookedTicket;
  late final flight = context.watch<FlightController>().bookedFlight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boarding Pass'),
        actions: [
          Padding(
            padding: AppPaddings.smallX,
            child: IconButton(
              onPressed: shareTicket,
              icon: const Icon(Icons.share),
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              AppAssets.worldMap,
              color: context.contrastColor,
              height: 150.sp,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              AppAssets.planeTrace,
              fit: BoxFit.contain,
              width: 200.sp,
            ),
          ),
          Positioned(
            bottom: 20.h,
            left: 20.w,
            right: 20.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BoardingPassCard(
                  flight: flight,
                  ticket: ticket,
                ),
                AppSizes.normalY,
                ElevatedButton(
                  onPressed: () async {
                    await generatePdf();
                    OpenAppFile.open(path!);
                  },
                  child: const Text("Download ticket"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> generatePdf() async {
    bool isGranted = await PdfController.isPermitted();
    if (isGranted == false) return;
    path = await PdfController.generateTicket(
      flight: flight,
      ticket: ticket,
    );
  }

  void shareTicket() async {
    if (path == null) await generatePdf();
    Share.shareXFiles(
      [XFile(path!)],
      text: 'My boarding pass for ${ticket.flightId}',
    );
  }
}
