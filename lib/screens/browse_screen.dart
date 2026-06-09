import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/movie.dart';
import 'detail_screen.dart';

enum SortOption { az, za, year, rating }

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  String _searchQuery = '';
  final Set<String> _selectedGenres = {};
  SortOption _sortOption = SortOption.rating;

  List<Movie> get _filteredMovies {
    var movies = sampleMovies.where((m) {
      final matchesSearch =
          m.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesGenre = _selectedGenres.isEmpty ||
          m.genres.any((g) => _selectedGenres.contains(g));
      return matchesSearch && matchesGenre;
    }).toList();

    switch (_sortOption) {
      case SortOption.az:
        movies.sort((a, b) => a.title.compareTo(b.title));
      case SortOption.za:
        movies.sort((a, b) => b.title.compareTo(a.title));
      case SortOption.year:
        movies.sort((a, b) => b.year.compareTo(a.year));
      case SortOption.rating:
        movies.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return movies;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 800;
            return CustomScrollView(
              slivers: [
                // 6.1 — Responsive Hero & Heading
                SliverToBoxAdapter(child: _buildHeader(context, isTablet)),

                // 6.2 — Search, Genre Chips & Sort Bar
                SliverToBoxAdapter(child: _buildSearchAndFilters()),

                // 6.3 — Responsive Movie List
                _buildMovieGrid(isTablet),
              ],
            );
          },
        ),
      ),
    );
  }

  // 6.1 Heading Section
  Widget _buildHeader(BuildContext context, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 32 : 16,
        vertical: isTablet ? 32 : 20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withAlpha(200),
            Theme.of(context).colorScheme.tertiary.withAlpha(160),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find a Movie',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: isTablet ? 40 : 28,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            '${sampleMovies.length} movies available',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // 6.2 Search + Genre Chips + Sort
  Widget _buildSearchAndFilters() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search movies...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _searchQuery = ''),
                    )
                  : null,
            ),
            onChanged: (v) => setState(() => _searchQuery = v),
          ),
          const SizedBox(height: 12),

          // Genre chips
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: allGenres.map((genre) {
              final selected = _selectedGenres.contains(genre);
              return FilterChip(
                label: Text(genre),
                selected: selected,
                onSelected: (val) => setState(() {
                  if (val) {
                    _selectedGenres.add(genre);
                  } else {
                    _selectedGenres.remove(genre);
                  }
                }),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),

          // Sort bar
          Row(
            children: [
              const Text('Sort: ', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButton<SortOption>(
                  value: _sortOption,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(
                        value: SortOption.az, child: Text('A – Z')),
                    DropdownMenuItem(
                        value: SortOption.za, child: Text('Z – A')),
                    DropdownMenuItem(
                        value: SortOption.year, child: Text('Year')),
                    DropdownMenuItem(
                        value: SortOption.rating, child: Text('Rating')),
                  ],
                  onChanged: (v) => setState(() => _sortOption = v!),
                ),
              ),
              Text(
                '${_filteredMovies.length} results',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 6.3 Responsive Grid
  Widget _buildMovieGrid(bool isTablet) {
    final movies = _filteredMovies;

    if (movies.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Text('No movies match your filters.'),
        ),
      );
    }

    if (isTablet) {
      // Two-column GridView for tablets (>= 800px)
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieCard(movie: movies[index]),
            childCount: movies.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
        ),
      );
    }

    // Single-column list for phones (< 800px)
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: _MovieCard(movie: movies[index]),
        ),
        childCount: movies.length,
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
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailScreen(movie: movie)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            AspectRatio(
              aspectRatio: 2 / 3,
              child: Image.network(
                movie.posterUrl,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, _) => Container(
                  color: Colors.grey.shade800,
                  child: const Icon(Icons.movie, size: 48),
                ),
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${movie.year}  •  ★ ${movie.rating.toStringAsFixed(1)}',
                    style:
                        const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
