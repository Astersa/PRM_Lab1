import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/book.dart';

class StorageService {
  static const String _fileName = 'my_books.json';

  Future<File> get _file async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  Future<List<Book>> loadBooks() async {
    try {
      final file = await _file;
      if (!await file.exists()) return [];
      final content = await file.readAsString();
      final List<dynamic> data = jsonDecode(content) as List<dynamic>;
      return data.map((e) => Book.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveBooks(List<Book> books) async {
    final file = await _file;
    await file.writeAsString(
      jsonEncode(books.map((b) => b.toJson()).toList()),
    );
  }
}
