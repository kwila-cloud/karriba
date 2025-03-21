import 'dart:io';

import 'package:intl/intl.dart';
import 'package:karriba/applicator_dao.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:pdf/widgets.dart' as pdf;

import 'record.dart';

class PDFGenerator {
  Future<void> generateAndSavePDF(Record recordData) async {
    final document = pdf.Document();
    final applicator = await ApplicatorDao().get(recordData.applicatorId);

    document.addPage(
      pdf.Page(
        build: (pdf.Context context) {
          return pdf.Column(
            crossAxisAlignment: pdf.CrossAxisAlignment.start,
            children: [
              pdf.Text(
                "Pesticide Record Form",
                style: pdf.TextStyle(
                  fontSize: 24,
                  fontWeight: pdf.FontWeight.bold,
                ),
              ),
              pdf.SizedBox(height: 20),

              pdf.Text(
                "1. Applicator Name and License Number: ${applicator?.name} - ${applicator?.licenseNumber ?? 'N/A'}",
              ),
              pdf.SizedBox(height: 10),

              pdf.Text("2. Name and Address of Owner/Advisor: N/A"),
              pdf.SizedBox(height: 10),

              pdf.Text(
                "3. Owner Contacted: ${recordData.customerInformedOfRei ? 'Yes' : 'No'}",
              ),
              pdf.SizedBox(height: 10),

              pdf.Text("4. Crop Treated: N/A"),
              pdf.SizedBox(height: 10),

              pdf.Text(
                "5. Name and Coordinates of Field: ${recordData.fieldName}",
              ),
              pdf.SizedBox(height: 10),

              pdf.Text("6. Pesticide Name and Registration Number/Rate: N/A"),
              pdf.SizedBox(height: 10),

              pdf.Text("7. Total Treated Area: N/A"),
              pdf.SizedBox(height: 10),

              pdf.Text("8. GPA: N/A"),
              pdf.SizedBox(height: 10),

              pdf.Text("9. Wind velocity/Direction Before: N/A"),
              pdf.SizedBox(height: 10),

              pdf.Text("10. Wind velocity/Direction After: N/A"),
              pdf.SizedBox(height: 10),

              pdf.Text("11. Temperature: N/A"),
              pdf.SizedBox(height: 20),

              pdf.Text(
                "Notes: ",
                style: pdf.TextStyle(fontWeight: pdf.FontWeight.bold),
              ),
              pdf.SizedBox(height: 10),
              pdf.Text("N/A"),
            ],
          );
        },
      ),
    );

    // TODO: use a different path on non-Android platforms
    final directoryPath = '/storage/emulated/0/Download';
    final formattedDate =
        DateFormat('yyyy-MM-dd_HH-mm').format(recordData.timestamp).toString();
    final fileName =
        '${applicator?.name ?? 'Unknown Applicator'} ${recordData.fieldName} $formattedDate.pdf'
            .replaceAll(' ', '_');

    final outputFilePath = path.join(directoryPath, fileName);
    final outputFile = File(outputFilePath);

    await outputFile.writeAsBytes(await document.save());
    OpenFile.open(outputFile.path);
  }
}
