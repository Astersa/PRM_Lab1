import 'package:flutter/material.dart';
import 'asset_books_screen.dart';
import 'my_books_screen.dart';

class Lab9HomeScreen extends StatelessWidget {
  const Lab9HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 9 – Local JSON')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.library_books, size: 36),
              title: const Text('9.1 – Asset Books',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Read JSON from assets & display list'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AssetBooksScreen())),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.storage, size: 36),
              title: const Text('9.2 & 9.3 – My Books (CRUD)',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Save/load from device + search/add/edit/delete'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const MyBooksScreen())),
            ),
          ),
        ],
      ),
    );
  }
}
