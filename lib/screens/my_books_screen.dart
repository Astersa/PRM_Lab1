// 9.2 & 9.3 – Save/Load from Device + CRUD
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/storage_service.dart';

class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({super.key});

  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen> {
  final StorageService _storage = StorageService();
  List<Book> _books = [];
  String _searchQuery = '';
  bool _loading = true;

  List<Book> get _filtered => _books
      .where((b) =>
          b.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          b.author.toLowerCase().contains(_searchQuery.toLowerCase()))
      .toList();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final books = await _storage.loadBooks();
    setState(() {
      _books = books;
      _loading = false;
    });
  }

  Future<void> _save() async {
    await _storage.saveBooks(_books);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Saved to device!')),
    );
  }

  void _addBook() => _showBookDialog();

  void _editBook(Book book) => _showBookDialog(existing: book);

  Future<void> _deleteBook(Book book) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Book'),
        content: Text('Delete "${book.title}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed != true) return;
    setState(() => _books.removeWhere((b) => b.id == book.id));
    await _storage.saveBooks(_books);
  }

  Future<void> _showBookDialog({Book? existing}) async {
    final titleCtrl =
        TextEditingController(text: existing?.title ?? '');
    final authorCtrl =
        TextEditingController(text: existing?.author ?? '');
    final yearCtrl =
        TextEditingController(text: existing?.year.toString() ?? '');

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existing == null ? 'Add Book' : 'Edit Book'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: authorCtrl,
              decoration: const InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: yearCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Year'),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final title = titleCtrl.text.trim();
              final author = authorCtrl.text.trim();
              final year = int.tryParse(yearCtrl.text.trim()) ?? 0;
              if (title.isEmpty) return;

              setState(() {
                if (existing == null) {
                  _books.add(Book(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: title,
                    author: author,
                    year: year,
                  ));
                } else {
                  final idx =
                      _books.indexWhere((b) => b.id == existing.id);
                  if (idx >= 0) {
                    _books[idx] =
                        existing.copyWith(title: title, author: author, year: year);
                  }
                }
              });
              _storage.saveBooks(_books);
              Navigator.pop(ctx);
            },
            child: Text(existing == null ? 'Add' : 'Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Books'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Save',
            onPressed: _save,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by title or author...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () =>
                                  setState(() => _searchQuery = ''),
                            )
                          : null,
                    ),
                    onChanged: (v) => setState(() => _searchQuery = v),
                  ),
                ),

                // List
                Expanded(
                  child: _filtered.isEmpty
                      ? const Center(
                          child: Text('No books yet. Tap + to add one!'))
                      : ListView.builder(
                          itemCount: _filtered.length,
                          itemBuilder: (context, index) {
                            final book = _filtered[index];
                            return ListTile(
                              leading: const Icon(Icons.menu_book),
                              title: Text(book.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle:
                                  Text('${book.author} · ${book.year}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _editBook(book),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _deleteBook(book),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBook,
        tooltip: 'Add Book',
        child: const Icon(Icons.add),
      ),
    );
  }
}
