import 'entities/Product.dart';

void main() {
  final p = Product.fromJson({'id': 0, 'name': 'Lily House', 'price': 120000.0, 'image': 'img'});
  Product.add(p);

  print('Before increase:');
  Product.printAll();

  Product.increasePricesBy10Percent();
  print('\nAfter 10% increase:');
  Product.printAll();

  print('\nSearch "lily":');
  Product.searchByName('lily').forEach(print);

  print('\nSort by price descending:');
  Product.sortByPrice(ascending: false);
  Product.printAll();

  Product.deleteById(0);
  print('\nAfter deleting id=0:');
  Product.printAll();
}