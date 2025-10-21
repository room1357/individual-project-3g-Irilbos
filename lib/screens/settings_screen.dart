import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🌈 Background gradasi sama seperti login & home screen
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8E2DE2),
              Color(0xFF4A00E0),
              Color(0xFF3A0CA3),
              Color(0xFF4361EE),
            ],
            stops: [0.1, 0.4, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 🔹 AppBar custom transparan
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 48), // untuk keseimbangan layout
                  ],
                ),
              ),

              // 🔹 Konten utama
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildSettingCard(
                        icon: Icons.dark_mode_outlined,
                        title: "Mode Gelap",
                        subtitle: "Aktifkan tema gelap aplikasi",
                        trailing: Switch(
                          value: _isDarkMode,
                          activeColor: const Color(0xFF5A189A),
                          onChanged: (value) {
                            setState(() {
                              _isDarkMode = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildSettingCard(
                        icon: Icons.person_outline,
                        title: "Ganti Nama Pengguna",
                        subtitle: "Atur nama tampilan kamu",
                        onTap: () {
                          _showChangeNameDialog(context);
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildSettingCard(
                        icon: Icons.info_outline,
                        title: "Tentang Aplikasi",
                        subtitle: "Versi dan informasi aplikasi",
                        onTap: () {
                          showAboutDialog(
                            context: context,
                            applicationName: "Expense Manager",
                            applicationVersion: "v1.0.0",
                            applicationLegalese: "© 2025 Expense Manager Team",
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildSettingCard(
                        icon: Icons.logout,
                        title: "Kembali ke Beranda",
                        subtitle: "Kembali ke halaman utama",
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Widget kartu pengaturan
  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white.withOpacity(0.9),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFF5A189A), size: 30),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(color: Colors.black54),
          ),
          trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 18),
        ),
      ),
    );
  }

  // 🔹 Dialog ganti nama
  void _showChangeNameDialog(BuildContext context) {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Ganti Nama Pengguna"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: "Nama baru",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5A189A),
            ),
            child: const Text("Simpan"),
            onPressed: () {
              final newName = nameController.text.trim();
              if (newName.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Nama diubah menjadi $newName")),
                );
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
