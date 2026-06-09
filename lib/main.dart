import 'dart:async';
import 'dart:convert';

// ============================================================
// LAB 3 – Advanced Dart Practice Exercises
// ============================================================

void main() async {
  await exercise1ProductRepository();
  await exercise2UserRepositoryJson();
  await exercise3AsyncMicrotask();
  await exercise4StreamTransformation();
  exercise5FactoryConstructorCache();
}

// ============================================================
// Exercise 1: Product Model & Repository
// ============================================================
class Product {
  final int id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  @override
  String toString() => 'Product(id: $id, name: $name, price: \$$price)';
}

class ProductRepository {
  final StreamController<Product> _controller =
      StreamController<Product>.broadcast();

  final List<Product> _products = [
    Product(id: 1, name: 'Laptop', price: 999.99),
    Product(id: 2, name: 'Mouse', price: 29.99),
    Product(id: 3, name: 'Keyboard', price: 59.99),
  ];

  Future<List<Product>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_products);
  }

  Stream<Product> liveAdded() => _controller.stream;

  void add(Product product) {
    _products.add(product);
    _controller.add(product);
  }

  void dispose() => _controller.close();
}

Future<void> exercise1ProductRepository() async {
  print('\n=== Exercise 1: Product Model & Repository ===');

  final repo = ProductRepository();

  // Listen to live stream before adding
  final subscription = repo.liveAdded().listen(
    (p) => print('Live added: $p'),
  );

  // Fetch all
  final all = await repo.getAll();
  print('All products:');
  for (var p in all) {
    print('  $p');
  }

  // Add a new product (triggers stream)
  repo.add(Product(id: 4, name: 'Monitor', price: 249.99));
  await Future.delayed(const Duration(milliseconds: 50));

  subscription.cancel();
  repo.dispose();
}

// ============================================================
// Exercise 2: User Repository with JSON
// ============================================================
class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'] as String, email: json['email'] as String);
  }

  @override
  String toString() => 'User(name: $name, email: $email)';
}

Future<List<User>> fetchUsers() async {
  await Future.delayed(const Duration(milliseconds: 300));
  const rawJson = '''
  [
    {"name": "Alice Smith", "email": "alice@example.com"},
    {"name": "Bob Jones",  "email": "bob@example.com"},
    {"name": "Carol White","email": "carol@example.com"}
  ]
  ''';
  final List<dynamic> data = jsonDecode(rawJson) as List<dynamic>;
  return data
      .map((e) => User.fromJson(e as Map<String, dynamic>))
      .toList();
}

Future<void> exercise2UserRepositoryJson() async {
  print('\n=== Exercise 2: User Repository with JSON ===');
  final users = await fetchUsers();
  print('Fetched ${users.length} users:');
  for (var u in users) {
    print('  $u');
  }
}

// ============================================================
// Exercise 3: Async + Microtask Debugging
// ============================================================
Future<void> exercise3AsyncMicrotask() async {
  print('\n=== Exercise 3: Async + Microtask Debugging ===');

  print('1 - synchronous start');

  scheduleMicrotask(() => print('3 - microtask (runs before next event-loop turn)'));

  Future(() => print('5 - Future (event queue, runs after microtasks)'));

  print('2 - synchronous end');

  // Yield to let microtask and Future run
  await Future.delayed(Duration.zero);
  print('4 - after first await (microtask already ran)');

  await Future.delayed(Duration.zero);
  print('6 - after second await');

  print('Explanation: scheduleMicrotask() is placed on the microtask queue,');
  print('which drains completely before any event-queue Future callbacks run.');
  print('Hence order: sync -> microtask -> event Future.');
}

// ============================================================
// Exercise 4: Stream Transformation
// ============================================================
Future<void> exercise4StreamTransformation() async {
  print('\n=== Exercise 4: Stream Transformation ===');

  final source = Stream.fromIterable([1, 2, 3, 4, 5]);

  final transformed = source
      .map((n) => n * n)        // square each number
      .where((n) => n % 2 == 0); // keep only even squares

  print('Squared & filtered (evens only):');
  await for (final value in transformed) {
    print('  $value');
  }
}

// ============================================================
// Exercise 5: Factory Constructors & Cache (Singleton)
// ============================================================
class Settings {
  static final Settings _instance = Settings._internal();

  String theme = 'light';
  String language = 'en';

  Settings._internal();

  factory Settings() => _instance;
}

void exercise5FactoryConstructorCache() {
  print('\n=== Exercise 5: Factory Constructor & Singleton ===');

  final a = Settings();
  final b = Settings();

  print('a.theme = ${a.theme}');

  b.theme = 'dark';
  print('After b.theme = "dark":');
  print('  a.theme = ${a.theme}');
  print('  b.theme = ${b.theme}');
  print('  identical(a, b) = ${identical(a, b)}');

  assert(identical(a, b), 'Settings must be a singleton');
  print('Singleton verified!');
}
