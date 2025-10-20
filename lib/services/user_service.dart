import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'package:uuid/uuid.dart';

class UserService {
  static const String _userKey = 'users';

  // Ambil semua user dari SharedPreferences
  Future<List<User>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList(_userKey) ?? [];
    return usersJson.map((u) => User.fromJson(json.decode(u))).toList();
  }

  // Simpan semua user ke SharedPreferences
  Future<void> _saveUsers(List<User> users) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = users.map((u) => json.encode(u.toJson())).toList();
    await prefs.setStringList(_userKey, usersJson);
  }

  // Daftar user baru
  Future<bool> registerUser(String name, String email, String password) async {
    final users = await getUsers();
    if (users.any((u) => u.email == email)) {
      // Email sudah terdaftar
      return false;
    }

    final newUser = User(
      id: const Uuid().v4(),
      name: name,
      email: email,
      password: password,
    );

    users.add(newUser);
    await _saveUsers(users);
    return true;
  }

  // Login user
  Future<User?> loginUser(String email, String password) async {
    final users = await getUsers();
    try {
      return users.firstWhere(
        (u) => u.email == email && u.password == password,
      );
    } catch (e) {
      return null;
    }
  }
}
