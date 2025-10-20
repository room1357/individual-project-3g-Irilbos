import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/expense.dart';

class StatisticsScreen extends StatelessWidget {
  final List<Expense> expenses;

  const StatisticsScreen({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    // Hitung total pengeluaran per kategori
    final Map<String, double> categoryTotals = {};

    for (var e in expenses) {
      categoryTotals[e.category] = (categoryTotals[e.category] ?? 0) + e.amount;
    }

    // Jika tidak ada data
    if (categoryTotals.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Statistik Pengeluaran')),
        body: const Center(
          child: Text(
            'Belum ada data pengeluaran.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }

    // Konversi ke data PieChart
    final sections = categoryTotals.entries.map((entry) {
      final color = Colors.primaries[
          categoryTotals.keys.toList().indexOf(entry.key) %
              Colors.primaries.length];
      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '${entry.key}\nRp${entry.value.toStringAsFixed(0)}',
        radius: 70,
        titleStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Pengeluaran')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Grafik Pengeluaran per Kategori',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: categoryTotals.entries.map((e) {
                  final color = Colors.primaries[
                      categoryTotals.keys.toList().indexOf(e.key) %
                          Colors.primaries.length];
                  return ListTile(
                    leading: CircleAvatar(backgroundColor: color),
                    title: Text(e.key),
                    trailing: Text('Rp ${e.value.toStringAsFixed(0)}'),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
