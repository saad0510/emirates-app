import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_app_file/open_app_file.dart';

import '../../../../app/assets.dart';
import '../../../../app/sizes.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../data/entities/flight.dart';
import '../controllers/pdf_controller.dart';
import '../widgets/boarding_pass_card.dart';

class BoardingPassScreen extends StatelessWidget {
  const BoardingPassScreen({super.key, required this.flight});

  final Flight flight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boarding Pass'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share),
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
                BoardingPassCard(flight: flight),
                AppSizes.normalY,
                ElevatedButton(
                  onPressed: generatePdf,
                  child: const Text("Download ticket"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void generatePdf() async {
    bool isGranted = await PdfController.isPermitted();
    if (isGranted == false) return;
    final path = await PdfController.generateTicket(flight);
    OpenAppFile.open(path);
  }
}
