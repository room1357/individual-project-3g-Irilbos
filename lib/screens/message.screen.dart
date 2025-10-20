import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.person, color: Colors.orange),
            title: Text('Adit'),
            subtitle: Text('Halo bro, jadi besok?'),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.orange),
            title: Text('Budi'),
            subtitle: Text('Oke, makasih ya 🙌'),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.orange),
            title: Text('Citra'),
            subtitle: Text('Nanti aku kabarin lagi ya~'),
          ),
        ],
      ),
    );
  }
}
