import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  final http.Client _client;
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Post>> getPosts() async {
    final response = await _client.get(Uri.parse('$_baseUrl/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('Failed to load posts (${response.statusCode})');
  }

  Future<Post> createPost({
    required int userId,
    required String title,
    required String body,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/posts'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'userId': userId, 'title': title, 'body': body}),
    );
    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    throw Exception('Failed to create post (${response.statusCode})');
  }
}
