import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/movie.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: sampleMovies.length,
        itemBuilder: (context, index) {
          final Movie movie = sampleMovies[index];
          return _MovieCard(movie: movie);
        },
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;
  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailScreen(movie: movie)),
        ),
        child: Row(
          children: [
            // Poster
            Hero(
              tag: 'poster_${movie.id}',
              child: Image.network(
                movie.posterUrl,
                width: 90,
                height: 130,
                fit: BoxFit.cover,
                errorBuilder: (ctx2, err, _) => Container(
                  width: 90,
                  height: 130,
                  color: Colors.grey.shade800,
                  child: const Icon(Icons.movie, size: 40),
                ),
              ),
            ),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(movie.rating.toStringAsFixed(1)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 4,
                      children: movie.genres
                          .take(2)
                          .map((g) => Chip(
                                label: Text(g,
                                    style: const TextStyle(fontSize: 10)),
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
