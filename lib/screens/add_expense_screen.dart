import 'package:flutter/material.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  final Function(Expense) onAdd;

  const AddExpenseScreen({super.key, required this.onAdd});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  final List<String> _categories = [
    'Makanan',
    'Transport',
    'Belanja',
    'Lainnya',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newExpense = Expense(
        id: DateTime.now().toString(),
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        date: _selectedDate,
        category: _selectedCategory ?? 'Lainnya',
      );

      widget.onAdd(newExpense);
      Navigator.pop(context);
    }
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Pengeluaran')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul Pengeluaran',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Judul wajib diisi'
                            : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah (Rp)',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Jumlah wajib diisi'
                            : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
                items:
                    _categories
                        .map(
                          (cat) =>
                              DropdownMenuItem(value: cat, child: Text(cat)),
                        )
                        .toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Tanggal: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                    ),
                  ),
                  TextButton(
                    onPressed: _pickDate,
                    child: const Text('Pilih Tanggal'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
