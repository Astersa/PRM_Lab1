// 9.1 – Read JSON from Assets
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/book.dart';

class AssetBooksScreen extends StatefulWidget {
  const AssetBooksScreen({super.key});

  @override
  State<AssetBooksScreen> createState() => _AssetBooksScreenState();
}

class _AssetBooksScreenState extends State<AssetBooksScreen> {
  late Future<List<Book>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = _loadAssetBooks();
  }

  Future<List<Book>> _loadAssetBooks() async {
    final raw = await rootBundle.loadString('assets/books.json');
    final List<dynamic> data = jsonDecode(raw) as List<dynamic>;
    return data.map((e) => Book.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('9.1 – Asset Books')),
      body: FutureBuilder<List<Book>>(
        future: _booksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final books = snapshot.data ?? [];
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(book.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${book.author} · ${book.year}'),
              );
            },
          );
        },
      ),
    );
  }
}
