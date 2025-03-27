import 'dart:io';

import 'package:intl/intl.dart';
import 'package:karriba/applicator_dao.dart';
import 'package:karriba/customer_dao.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;

import 'record.dart';

class PDFGenerator {
  Future<void> generateAndSavePDF(Record recordData) async {
    final document = pdf.Document();
    final applicator = await ApplicatorDao().get(recordData.applicatorId);
    final customer = await CustomerDao().get(recordData.customerId);
    final formattedDate =
        DateFormat('yyyy-MM-dd').format(recordData.timestamp).toString();
    final formattedTime =
        DateFormat('HH_mm').format(recordData.timestamp).toString();
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

    document.addPage(
      pdf.Page(
        build: (pdf.Context context) {
          return pdf.Column(
            crossAxisAlignment: pdf.CrossAxisAlignment.start,
            children: [
              pdf.Row(
                mainAxisAlignment: pdf.MainAxisAlignment.spaceBetween,
                children: [
                  pdf.Text(
                    "Pesticide Record Form",
                    style: pdf.TextStyle(
                      fontSize: 26,
                      fontWeight: pdf.FontWeight.bold,
                    ),
                  ),
                  pdf.Text(
                    formattedDate, // Form date
                    style: pdf.TextStyle(
                      fontSize: 16,
                      fontWeight: pdf.FontWeight.normal,
                    ),
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
              _buildRowWithBottomBox("Pesticides", "", height: 100),
              _buildInlineRow("Wind Velocity", windVelocityValue),
              _buildInlineRow(
                "Wind Direction",
                recordData.windDirection == null
                    ? ""
                    : recordData.windDirection.toString(),
              ),
              _buildInlineRow("Temperature", temperatureValue, suffix: "°F"),
              pdf.SizedBox(height: 12),
              _buildRowWithBottomBox("Notes", recordData.notes, height: 100),
            ],
          );
        },
      ),
    );

    // TODO: use a different path on non-Android platforms
    final directoryPath = '/storage/emulated/0/Download';
    final fileName =
        '${applicator?.name ?? 'Unknown Applicator'} ${recordData.fieldName} ${formattedDate}_$formattedTime.pdf'
            .replaceAll(' ', '_')
            // Remove all dangerous characters
            .replaceAll(RegExp(r'[^\w\-_]'), '');

    final outputFilePath = path.join(directoryPath, fileName);
    final outputFile = File(outputFilePath);

    await outputFile.writeAsBytes(await document.save());
    OpenFile.open(outputFile.path);
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
