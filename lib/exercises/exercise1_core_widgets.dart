import 'package:flutter/material.dart';

class Exercise1Screen extends StatelessWidget {
  const Exercise1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 1: Core Widgets')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headline Text
            Text(
              'Flutter Core Widgets',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // Icon
            const Row(
              children: [
                Icon(Icons.flutter_dash, size: 48, color: Colors.blue),
                SizedBox(width: 8),
                Text('Flutter Dash Icon', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),

            // Image.network
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/seed/flutter/400/200',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context2, err, _) => Container(
                  height: 200,
                  color: Colors.grey.shade200,
                  child: const Center(child: Icon(Icons.broken_image, size: 48)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card with ListTile
            Card(
              elevation: 4,
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: const Text('John Doe'),
                subtitle: const Text('Flutter Developer'),
                trailing: const Icon(Icons.more_vert),
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ListTile tapped!')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
