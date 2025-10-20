import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  static Future<List<String>> getCategories(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('categories_$userEmail');
    return data ?? ['Makanan', 'Transport', 'Hiburan', 'Tagihan'];
  }

  static Future<void> addCategory(String userEmail, String category) async {
    final prefs = await SharedPreferences.getInstance();
    final categories = await getCategories(userEmail);
    if (!categories.contains(category)) {
      categories.add(category);
      await prefs.setStringList('categories_$userEmail', categories);
    }
  }

  static Future<void> deleteCategory(String userEmail, String category) async {
    final prefs = await SharedPreferences.getInstance();
    final categories = await getCategories(userEmail);
    categories.remove(category);
    await prefs.setStringList('categories_$userEmail', categories);
  }
}
