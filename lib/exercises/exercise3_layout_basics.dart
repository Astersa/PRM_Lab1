import 'package:flutter/material.dart';

class Exercise3Screen extends StatelessWidget {
  const Exercise3Screen({super.key});

  static const List<String> _movies = [
    'Inception',
    'Interstellar',
    'The Dark Knight',
    'Dunkirk',
    'Tenet',
    'Oppenheimer',
    'Memento',
    'The Prestige',
    'Batman Begins',
    'Following',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 3: Layout Basics')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section 1 – header area with Padding
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Movie List',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          // Section 2 – description with SizedBox spacing
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'A curated selection of must-watch films.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 12),

          // Section 3 – divider
          const Divider(height: 1),
          const SizedBox(height: 8),

          // Section 4 – ListView.builder (uses Expanded to avoid unbounded height)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      // 8px spacing on left already from horizontal padding
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.indigo.shade100,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(_movies[index], style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                );
              },
            ),
          ),
          // 16px bottom padding
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
