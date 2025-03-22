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
    final customer = await CustomerDao().get(recordData.applicatorId);
    final formattedDate = DateFormat('yyyy-MM-dd').format(recordData.timestamp).toString();
    final formattedTime = DateFormat('HH_mm').format(recordData.timestamp).toString();

    document.addPage(
      pdf.Page(
        build: (pdf.Context context) {
          return pdf.Column(
            crossAxisAlignment: pdf.CrossAxisAlignment.start,
            children: [
              pdf.Text(
                "Pesticide Record Form",
                style: pdf.TextStyle(fontSize: 26, fontWeight: pdf.FontWeight.bold),
              ),
              pdf.SizedBox(height: 10),

              _buildRowWithBottomBox("Applicator Name and License Number", "${applicator?.name} - ${applicator?.licenseNumber}"),
              _buildRowWithBottomBox("Name and Address of Owner/Advisor",
                  "${customer?.name}, ${customer?.streetAddress}, ${customer?.city}, ${customer?.state}, ${customer?.zipCode}"),

              _buildInlineRow("Owner Contacted", recordData.customerInformedOfRei ? 'Yes' : 'No'),
              _buildInlineRow("Crop Treated", ""),
              _buildInlineRow("Name and Coordinates of Field", recordData.fieldName),
              _buildRowWithBottomBox("Pesticide Name and Registration Number/Rate", "", height: 50),
              _buildInlineRow("Total Treated Area", ""),
              _buildInlineRow("GPA", ""),
              _buildInlineRow("Wind velocity Before", recordData.windSpeedBefore.toString()),
              _buildInlineRow("Wind velocity After", recordData.windSpeedAfter.toString()),
              _buildInlineRow("Wind direction", recordData.windDirection.toString()),
              _buildInlineRow("Temperature", recordData.temperature.toString()),

              pdf.SizedBox(height: 10),
              _buildRowWithBottomBox("Notes", "", height: 100),
              _buildBox("", height: 100),
            ],
          );
        },
      ),
    );

    // TODO: use a different path on non-Android platforms
    final directoryPath = '/storage/emulated/0/Download';
    final fileName =
        '${applicator?.name ?? 'Unknown Applicator'} ${recordData.fieldName} ${formattedDate}_$formattedTime.pdf'
            .replaceAll(' ', '_');

    final outputFilePath = path.join(directoryPath, fileName);
    final outputFile = File(outputFilePath);

    await outputFile.writeAsBytes(await document.save());
    OpenFile.open(outputFile.path);
  }

  pdf.Widget _buildRowWithBottomBox(String label, String value, {double height = 25}) {
    return pdf.Padding(
      padding: pdf.EdgeInsets.symmetric(vertical: 5),
      child: pdf.Column(
        crossAxisAlignment: pdf.CrossAxisAlignment.start,
        children: [
          pdf.Text("$label:", style: pdf.TextStyle(fontSize: 16, fontWeight: pdf.FontWeight.bold)),
          pdf.SizedBox(height: 5),
          _buildBox(value, height: height),
        ],
      ),
    );
  }

  pdf.Widget _buildInlineRow(String label, String value) {
    return pdf.Padding(
      padding: pdf.EdgeInsets.symmetric(vertical: 5),
      child: pdf.Row(
        crossAxisAlignment: pdf.CrossAxisAlignment.start,
        children: [
          pdf.Text("$label:", style: pdf.TextStyle(fontSize: 16, fontWeight: pdf.FontWeight.bold)),
          pdf.SizedBox(width: 5),
          pdf.Expanded(child: _buildBox(value)),
        ],
      ),
    );
  }

  pdf.Widget _buildBox(String value, {double height = 25}) {
    return pdf.Container(
      width: double.infinity, // Extend box to document edges
      padding: pdf.EdgeInsets.all(5),
      decoration: pdf.BoxDecoration(
        border: pdf.Border.all(color: PdfColors.black),
      ),
      constraints: pdf.BoxConstraints(minHeight: height),
      child: pdf.Text(value, style: pdf.TextStyle(fontSize: 14, fontWeight: pdf.FontWeight.bold)),
    );
  }
}
