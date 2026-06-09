import 'dart:async';

// ============================================================
// LAB 2 – Dart Essentials Practice Lab
// ============================================================

void main() async {
  exercise1BasicSyntax();
  exercise2Collections();
  exercise3ControlFlow();
  exercise4OOP();
  await exercise5AsyncStreams();
}

// ============================================================
// Exercise 1: Basic Syntax & Data Types
// ============================================================
void exercise1BasicSyntax() {
  print('\n=== Exercise 1: Basic Syntax & Data Types ===');

  int age = 21;
  double gpa = 3.85;
  String name = 'Alice';
  bool isEnrolled = true;

  print('Name: $name');
  print('Age: $age');
  print('GPA: $gpa');
  print('Enrolled: $isEnrolled');
  print('Next year age: ${age + 1}');
  print('GPA rounded: ${gpa.toStringAsFixed(1)}');
}

// ============================================================
// Exercise 2: Collections & Operators
// ============================================================
void exercise2Collections() {
  print('\n=== Exercise 2: Collections & Operators ===');

  // List
  List<String> fruits = ['apple', 'banana', 'cherry'];
  fruits.add('date');
  fruits.remove('banana');
  print('Fruits: $fruits');
  print('First fruit: ${fruits[0]}');

  // Set
  Set<int> numbers = {1, 2, 3, 4, 4, 5};
  numbers.add(6);
  print('Set (no duplicates): $numbers');

  // Map
  Map<String, int> scores = {'math': 90, 'english': 85, 'science': 92};
  scores['history'] = 88;
  print('Scores: $scores');
  print('Math score: ${scores['math']}');

  // Operators
  int a = 15, b = 4;
  print('$a + $b = ${a + b}');
  print('$a % $b = ${a % b}');
  print('$a > $b: ${a > b}');
  print('$a == $b: ${a == b}');
}

// ============================================================
// Exercise 3: Control Flow & Functions
// ============================================================
void exercise3ControlFlow() {
  print('\n=== Exercise 3: Control Flow & Functions ===');

  // if/else
  int score = 78;
  if (score >= 90) {
    print('Grade: A');
  } else if (score >= 75) {
    print('Grade: B');
  } else {
    print('Grade: C');
  }

  // switch
  int day = 3;
  switch (day) {
    case 1:
      print('Monday');
      break;
    case 2:
      print('Tuesday');
      break;
    case 3:
      print('Wednesday');
      break;
    default:
      print('Other day');
  }

  // for loop
  for (int i = 1; i <= 3; i++) {
    print('Count: $i');
  }

  // for-in
  List<String> colors = ['red', 'green', 'blue'];
  for (var color in colors) {
    print('Color: $color');
  }

  // forEach with arrow
  colors.forEach((c) => print('forEach: $c'));

  // Normal function
  print('add(10, 20) = ${add(10, 20)}');

  // Arrow function
  print('square(7) = ${square(7)}');
}

int add(int x, int y) {
  return x + y;
}

int square(int x) => x * x;

// ============================================================
// Exercise 4: Intro to OOP
// ============================================================
class Car {
  String brand;
  int year;
  double fuelLevel;

  Car({required this.brand, required this.year, this.fuelLevel = 1.0});

  void describe() {
    print('Car: $brand ($year), fuel: ${(fuelLevel * 100).toStringAsFixed(0)}%');
  }

  void drive() {
    print('$brand is driving on fuel...');
  }
}

class ElectricCar extends Car {
  double batteryLevel;

  ElectricCar({
    required super.brand,
    required super.year,
    this.batteryLevel = 1.0,
  }) : super(fuelLevel: 0);

  @override
  void drive() {
    print(
      '$brand is driving silently on battery '
      '(${(batteryLevel * 100).toStringAsFixed(0)}%)...',
    );
  }

  void charge() {
    batteryLevel = 1.0;
    print('$brand fully charged!');
  }
}

void exercise4OOP() {
  print('\n=== Exercise 4: Intro to OOP ===');

  Car myCar = Car(brand: 'Toyota', year: 2022);
  myCar.describe();
  myCar.drive();

  ElectricCar tesla = ElectricCar(
    brand: 'Tesla Model 3',
    year: 2024,
    batteryLevel: 0.3,
  );
  tesla.describe();
  tesla.drive();
  tesla.charge();
}

// ============================================================
// Exercise 5: Async, Future, Null Safety & Streams
// ============================================================
Future<String> fetchUsername() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'john_doe';
}

Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(const Duration(milliseconds: 200));
    yield i;
  }
}

Future<void> exercise5AsyncStreams() async {
  print('\n=== Exercise 5: Async, Future, Null Safety & Streams ===');

  // async / await
  print('Fetching username...');
  String username = await fetchUsername();
  print('Username: $username');

  // Null safety
  String? maybeNull;
  print('Nullable value: $maybeNull');
  print('With ?? operator: ${maybeNull ?? "default_value"}');

  String definitelyNotNull = maybeNull ?? 'fallback';
  print('Non-null result: $definitelyNotNull');

  // Stream with listener
  print('Counting via stream:');
  final completer = Completer<void>();
  final stream = countStream(5);
  stream.listen(
    (value) => print('Stream value: $value'),
    onDone: () => completer.complete(),
  );
  await completer.future;

  print('All exercises complete!');
}
