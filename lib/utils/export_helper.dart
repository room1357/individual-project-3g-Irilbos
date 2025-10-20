import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/expense.dart';

class ExportHelper {
  /// 📤 Export data ke CSV
  static Future<String> exportToCSV(List<Expense> expenses) async {
    List<List<dynamic>> rows = [
      ['ID', 'Judul', 'Jumlah', 'Tanggal', 'Kategori'],
    ];

    for (var e in expenses) {
      rows.add([e.id, e.title, e.amount, e.date.toIso8601String(), e.category]);
    }

    String csvData = const ListToCsvConverter().convert(rows);

    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/expenses_export.csv';
    final file = File(path);
    await file.writeAsString(csvData);

    return path;
  }

  /// 📄 Export data ke PDF
  static Future<String> exportToPDF(List<Expense> expenses) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Daftar Pengeluaran',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Table.fromTextArray(
                headers: ['Judul', 'Jumlah (Rp)', 'Tanggal', 'Kategori'],
                data:
                    expenses
                        .map(
                          (e) => [
                            e.title,
                            e.amount.toStringAsFixed(0),
                            e.date.toLocal().toString().split(' ')[0],
                            e.category,
                          ],
                        )
                        .toList(),
              ),
            ],
          );
        },
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/expenses_export.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());

    return path;
  }
}
