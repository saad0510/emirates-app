import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../app/assets.dart';
import '../../../../core/utils/date_time_service.dart';
import '../../data/entities/flight.dart';
import '../../data/entities/flight_class.dart';

class PdfController {
  PdfController._();

  static Future<bool> isPermitted() async {
    final isGranted = await Permission.storage.request().isGranted;
    return isGranted && Platform.isAndroid;
  }

  static Future<String> generateTicket(Flight flight) async {
    final pdf = Document();

    final ByteData bytes = await rootBundle.load(AppAssets.logo);
    final Uint8List logoImg = bytes.buffer.asUint8List();

    Widget text(String text, {bool bold = false}) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: bold ? FontWeight.bold : null,
          ),
        ),
      );
    }

    pdf.addPage(
      Page(
        pageFormat: PdfPageFormat.a4,
        margin: const EdgeInsets.all(50).copyWith(bottom: 0),
        build: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(MemoryImage(logoImg), width: 200),
              SizedBox(height: 20),
              Text(
                'Boarding Pass',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              Table(
                tableWidth: TableWidth.max,
                border: TableBorder.all(color: PdfColors.red, width: 1),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      text('Full Name', bold: true),
                      text('James Bond'),
                    ],
                  ),
                  TableRow(
                    children: [
                      text('Departure city', bold: true),
                      text(
                        '${flight.departureCity.name} (${flight.departureCity.code})',
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      text('Arrival city', bold: true),
                      text(
                        '${flight.arrivalCity.name} (${flight.arrivalCity.code})',
                      )
                    ],
                  ),
                  TableRow(
                    children: [
                      text('Date & Time', bold: true),
                      text(DateTimeService.dateTimeStr(flight.dateTime, full: true)),
                    ],
                  ),
                  TableRow(
                    children: [
                      text('Flight Number', bold: true),
                      text(flight.fid),
                    ],
                  ),
                  TableRow(
                    children: [
                      text('Seat Number', bold: true),
                      text('A2'),
                    ],
                  ),
                  TableRow(
                    children: [
                      text('Terminal', bold: true),
                      text('5'),
                    ],
                  ),
                  TableRow(
                    children: [
                      text('Class', bold: true),
                      text(FlightClass.business.name),
                    ],
                  ),
                  TableRow(
                    children: [
                      text('Passport ID', bold: true),
                      text('58942157'),
                    ],
                  ),
                ],
              ),
              Spacer(),
              text('Scan this Barcode'),
              BarcodeWidget(
                data: flight.fid,
                barcode: Barcode.code128(),
                height: 50,
                width: 200,
                drawText: false,
              ),
              SizedBox(height: 20),
              Text(DateTimeService.dateTimeStr(DateTime.now())),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
    return await savePdf(pdf, flight.fid);
  }

  static Future<String> savePdf(Document doc, String name) async {
    final output = await getExternalStorageDirectory();
    final bytes = await doc.save();

    final file = File("${output!.path}/$name.pdf");
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
