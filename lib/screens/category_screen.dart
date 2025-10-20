import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<Category> _categories = [
    Category(id: '1', name: 'Makanan'),
    Category(id: '2', name: 'Transport'),
    Category(id: '3', name: 'Belanja'),
  ];

  final TextEditingController _nameController = TextEditingController();

  void _addCategory() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Tambah Kategori'),
            content: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama kategori'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isNotEmpty) {
                    setState(() {
                      _categories.add(
                        Category(
                          id: DateTime.now().toString(),
                          name: _nameController.text,
                        ),
                      );
                    });
                    _nameController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
    );
  }

  void _deleteCategory(String id) {
    setState(() {
      _categories.removeWhere((cat) => cat.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Kategori'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _addCategory),
        ],
      ),
      body:
          _categories.isEmpty
              ? const Center(child: Text('Belum ada kategori.'))
              : ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      title: Text(cat.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteCategory(cat.id),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
