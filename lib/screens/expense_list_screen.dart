import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'add_expense_screen.dart';
import '../utils/export_helper.dart';

class ExpenseListScreen extends StatelessWidget {
  final List<Expense> expenses;
  final Function(Expense) onAdd;
  final Function(String) onDelete;

  const ExpenseListScreen({
    super.key,
    required this.expenses,
    required this.onAdd,
    required this.onDelete,
  });

  void _navigateToAdd(BuildContext context) async {
    final newExpense = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExpenseScreen(onAdd: onAdd),
      ),
    );
    if (newExpense != null) onAdd(newExpense);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pengeluaran'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Export ke CSV',
            onPressed: () async {
              final path = await ExportHelper.exportToCSV(expenses);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Berhasil diekspor ke $path')),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'Export ke PDF',
            onPressed: () async {
              final path = await ExportHelper.exportToPDF(expenses);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Berhasil diekspor ke $path')),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Tambah',
            onPressed: () => _navigateToAdd(context),
          ),
        ],
      ),
      body: expenses.isEmpty
          ? const Center(child: Text('Belum ada pengeluaran.'))
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final e = expenses[index];
                return ListTile(
                  title: Text(e.title),
                  subtitle: Text('${e.category} - ${e.date.toLocal()}'),
                  trailing: Text('Rp ${e.amount.toStringAsFixed(0)}'),
                  onLongPress: () => onDelete(e.id),
                );
              },
            ),
    );
  }
}
