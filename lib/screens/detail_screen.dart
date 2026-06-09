import 'package:flutter/material.dart';
import '../models/movie.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = false;
  double _userRating = 0;

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero banner with gradient overlay
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'poster_${movie.id}',
                    child: Image.network(
                      movie.posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx2, err, _) => Container(
                        color: Colors.grey.shade800,
                        child: const Icon(Icons.movie, size: 80),
                      ),
                    ),
                  ),
                  // Gradient overlay
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating row
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        movie.rating.toStringAsFixed(1),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text(' / 10',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Genre chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: movie.genres
                        .map((g) => Chip(label: Text(g)))
                        .toList(),
                  ),
                  const SizedBox(height: 16),

                  // Overview
                  const Text(
                    'Overview',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview,
                    style: const TextStyle(height: 1.5, fontSize: 15),
                  ),
                  const SizedBox(height: 20),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton.filled(
                        icon: Icon(
                          _isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                        color: _isFavorite ? Colors.red : null,
                        tooltip: 'Favorite',
                        onPressed: () =>
                            setState(() => _isFavorite = !_isFavorite),
                      ),
                      IconButton.filled(
                        icon: const Icon(Icons.star_rate),
                        tooltip: 'Rate',
                        onPressed: () => _showRatingDialog(context),
                      ),
                      IconButton.filled(
                        icon: const Icon(Icons.share),
                        tooltip: 'Share',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Sharing ${movie.title}...')),
                          );
                        },
                      ),
                    ],
                  ),
                  if (_userRating > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Your rating: ${_userRating.toStringAsFixed(1)}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.amber),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Trailers
                  const Text(
                    'Trailers',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: movie.trailers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.play_circle_fill,
                            color: Colors.red, size: 36),
                        title: Text(movie.trailers[index]),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Playing: ${movie.trailers[index]}'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    double tempRating = _userRating;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rate this movie'),
        content: StatefulBuilder(
          builder: (context, setInnerState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(tempRating.toStringAsFixed(1)),
              Slider(
                value: tempRating,
                min: 0,
                max: 10,
                divisions: 20,
                label: tempRating.toStringAsFixed(1),
                onChanged: (v) => setInnerState(() => tempRating = v),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              setState(() => _userRating = tempRating);
              Navigator.pop(ctx);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
