import 'dart:convert'; // Import for base64 encoding
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:karriba/applicator_dao.dart';
import 'package:karriba/customer_dao.dart';
import 'package:karriba/pesticide/pesticide_dao.dart';
import 'package:karriba/record_pesticide/record_pesticide_dao.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:web/web.dart' as web; // Import for web

import 'record.dart';

class PDFGenerator {
  Future<void> generateAndSavePDF(Record recordData) async {
    final document = pdf.Document();
    final applicator = await ApplicatorDao().get(recordData.applicatorId);
    final customer = await CustomerDao().get(recordData.customerId);
    final recordPesticides = await RecordPesticideDao().queryByRecordId(
      recordData.id!,
    );
    final pesticides = await PesticideDao().queryAllRows();
    final pesticidesMap = {
      for (var p in pesticides) p.id: '${p.name} (${p.registrationNumber})',
    };

    final formattedDate =
        DateFormat('MM/dd/yyyy').format(recordData.startTimestamp).toString();
    final formattedStartTime =
        DateFormat('h:mm a').format(recordData.startTimestamp).toString();
    final formattedEndTime =
        DateFormat('h:mm a').format(recordData.endTimestamp).toString();
    final beforeSpeed = recordData.windSpeedBefore;
    final afterSpeed = recordData.windSpeedAfter;
    final windVelocityValue =
        (beforeSpeed == null
            ? ''
            : 'Before: '
                '${beforeSpeed.toStringAsFixed(1)} mph ') +
        (afterSpeed == null
            ? ''
            : 'After: '
                '${afterSpeed.toStringAsFixed(1)} mph');
    final temperature = recordData.temperature;
    final temperatureValue =
        temperature == null ? '' : temperature.toStringAsFixed(1);
    final pesticidesString = recordPesticides
        .map(
          (rp) =>
              '${pesticidesMap[rp.pesticideId] ?? 'Unknown'} - ${rp.rate} ${rp.rateUnit}',
        )
        .join(', ');

    document.addPage(
      pdf.Page(
        margin: pdf.EdgeInsets.all(36), // 0.5 inches (36 points) on all sides
        pageFormat: PdfPageFormat.letter,
        build: (pdf.Context context) {
          return pdf.Column(
            crossAxisAlignment: pdf.CrossAxisAlignment.start,
            children: [
              pdf.Row(
                crossAxisAlignment: pdf.CrossAxisAlignment.start,
                mainAxisAlignment: pdf.MainAxisAlignment.spaceBetween,
                children: [
                  pdf.Text(
                    "Pesticide Record Form",
                    style: pdf.TextStyle(
                      fontSize: 26,
                      fontWeight: pdf.FontWeight.bold,
                    ),
                  ),
                  pdf.Column(
                    crossAxisAlignment: pdf.CrossAxisAlignment.end,
                    children: [
                      pdf.Text(
                        formattedDate,
                        style: pdf.TextStyle(
                          fontSize: 12,
                          fontWeight: pdf.FontWeight.normal,
                        ),
                      ),
                      pdf.Text(
                        '$formattedStartTime - $formattedEndTime',
                        style: pdf.TextStyle(
                          fontSize: 12,
                          fontWeight: pdf.FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pdf.SizedBox(height: 12),
              _buildInlineRow(
                "Applicator",
                "${applicator?.name} - ${applicator?.licenseNumber}",
              ),
              _buildRowWithBottomBox(
                "Owner",
                "${customer?.name}, ${customer?.streetAddress}, ${customer?.city}, ${customer?.state}, ${customer?.zipCode}",
              ),
              _buildInlineRow(
                "Owner Informed of REI",
                recordData.customerInformedOfRei ? 'Yes' : 'No',
              ),
              _buildInlineRow("Field", recordData.fieldName),
              _buildInlineRow("Crop Treated", recordData.crop),
              _buildInlineRow(
                "Total Treated Area",
                recordData.totalArea.toString(),
                suffix: "Acres",
              ),
              _buildInlineRow(
                "Price per Acre",
                recordData.pricePerAcre == 0
                    ? ""
                    : "${recordData.pricePerAcre}",
              ),
              _buildInlineRow(
                "Spray Volume",
                recordData.sprayVolume.toString(),
                suffix: "GPA",
              ),
              _buildRowWithBottomBox(
                "Pesticides",
                pesticidesString,
                height: 100,
              ),
              _buildInlineRow("Wind Velocity", windVelocityValue),
              _buildInlineRow(
                "Wind Direction",
                recordData.windDirection == null
                    ? ""
                    : recordData.windDirection.toString(),
              ),
              _buildInlineRow("Temperature", temperatureValue, suffix: "°F"),
              _buildRowWithBottomBox("Notes", recordData.notes, height: 100),
            ],
          );
        },
      ),
    );

    // Generate file name
    final fileName =
        '${applicator?.name ?? 'Unknown Applicator'} ${recordData.fieldName}.pdf'
            .replaceAll(' ', '_')
            // Remove all dangerous characters
            .replaceAll(RegExp(r'[^\w\-_]'), '');

    if (kIsWeb) {
      await _saveAsPdfWeb(document, fileName);
    } else {
      await _saveAsPdfMobile(document, fileName);
    }
  }

  Future<void> _saveAsPdfWeb(pdf.Document document, String fileName) async {
    final bytes = await document.save();
    final blob = web.Blob([bytes], 'application/pdf');
    final url = web.URL.createObjectURL(blob);
    final anchor = web.document.createElement('a') as web.AnchorElement;
    anchor.href = url;
    anchor.download = fileName;
    anchor.click();
    web.URL.revokeObjectURL(url);
  }

  Future<void> _saveAsPdfMobile(pdf.Document document, String fileName) async {
    final bytes = await document.save();

    // TODO: use different path for iOS
    const dir = '/storage/emulated/0/Download';
    final file = File(join(dir, fileName));

    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  pdf.Widget _buildRowWithBottomBox(
    String label,
    String value, {
    double height = 24,
    String suffix = '',
  }) {
    return pdf.Padding(
      padding: pdf.EdgeInsets.symmetric(vertical: 4),
      child: pdf.Column(
        crossAxisAlignment: pdf.CrossAxisAlignment.start,
        children: [
          pdf.Text(
            label,
            style: pdf.TextStyle(fontSize: 16, fontWeight: pdf.FontWeight.bold),
          ),
          pdf.SizedBox(height: 4),
          _buildBox(value, height: height, suffix: suffix),
        ],
      ),
    );
  }

  pdf.Widget _buildInlineRow(String label, String value, {String suffix = ''}) {
    return pdf.Padding(
      padding: pdf.EdgeInsets.symmetric(vertical: 4),
      child: pdf.Row(
        crossAxisAlignment: pdf.CrossAxisAlignment.center,
        children: [
          pdf.Text(
            label,
            style: pdf.TextStyle(fontSize: 16, fontWeight: pdf.FontWeight.bold),
          ),
          pdf.SizedBox(width: 8),
          pdf.Expanded(child: _buildBox(value, suffix: suffix)),
        ],
      ),
    );
  }

  pdf.Widget _buildBox(String value, {double height = 24, String suffix = ''}) {
    return pdf.Container(
      width: double.infinity,
      // Extend box to document edges
      padding: pdf.EdgeInsets.all(4),
      decoration: pdf.BoxDecoration(
        border: pdf.Border.all(color: PdfColors.black),
      ),
      constraints: pdf.BoxConstraints(minHeight: height),
      child: pdf.Text(
        value == '' ? '' : '$value $suffix',
        style: pdf.TextStyle(fontSize: 14, fontWeight: pdf.FontWeight.bold),
      ),
    );
  }
}
