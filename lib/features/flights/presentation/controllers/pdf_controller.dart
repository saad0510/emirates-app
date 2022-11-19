import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../../../../app/assets.dart';
import '../../../../core/utils/date_time_service.dart';
import '../../data/entities/flight.dart';

class PdfController {
  PdfController._();

  static Future<bool> isPermitted() async {
    final isGranted = await Permission.storage.request().isGranted;
    return isGranted && Platform.isAndroid;
  }

  static Future<String> generateTicket(Flight flight) async {
    final pdf = pw.Document();

    final ByteData bytes = await rootBundle.load(AppAssets.logo);
    final Uint8List logoImg = bytes.buffer.asUint8List();

    pw.Widget text(String text, {bool bold = false}) {
      return pw.Padding(
        padding: const pw.EdgeInsets.all(10),
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: bold ? pw.FontWeight.bold : null,
          ),
        ),
      );
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(50).copyWith(bottom: 0),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Image(pw.MemoryImage(logoImg), width: 200),
              pw.SizedBox(height: 30),
              pw.Table(
                tableWidth: pw.TableWidth.max,
                border: pw.TableBorder.all(color: PdfColors.red, width: 1),
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                children: [
                  pw.TableRow(
                    children: [
                      text('Departure city', bold: true),
                      text(
                        '${flight.departureCity.name} (${flight.departureCity.code})',
                      )
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      text('Arrival city', bold: true),
                      text(
                        '${flight.arrivalCity.name} (${flight.arrivalCity.code})',
                      )
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      text('Date & Time', bold: true),
                      text(DateTimeService.dateTimeStr(flight.dateTime, full: true)),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      text('Full Name', bold: true),
                      text('James Bond'),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      text('Flight Number', bold: true),
                      text(flight.fid),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      text('Seat Number', bold: true),
                      text('A2'),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      text('Terminal', bold: true),
                      text('5'),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      text('Class', bold: true),
                      text(flight.flightClass.name),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      text('Passport ID', bold: true),
                      text('58942157'),
                    ],
                  ),
                ],
              ),
              pw.Spacer(),
              text('Scan this Barcode'),
              pw.BarcodeWidget(
                data: flight.fid,
                barcode: pw.Barcode.code128(),
                height: 50,
                width: 200,
                drawText: false,
              ),
              pw.SizedBox(height: 20),
              pw.Text(DateTimeService.dateTimeStr(DateTime.now())),
              pw.SizedBox(height: 20),
            ],
          );
        },
      ),
    );
    return await savePdf(pdf, flight.fid);
  }

  static Future<String> savePdf(pw.Document doc, String name) async {
    final output = await getExternalStorageDirectory();
    final bytes = await doc.save();

    final file = File("${output!.path}/$name.pdf");
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
