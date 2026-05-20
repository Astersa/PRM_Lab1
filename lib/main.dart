import 'product.dart';
import 'product_repository.dart';

void main() {
  print("=== INIT PRODUCTS ===");
  ProductRepository.products.forEach((p) {
    print("${p.id} - ${p.name} - ${p.price}");
  });

  ProductRepository.add(
    Product(id: 4, name: "Macbook M3", image: "", price: 3000),
  );

  ProductRepository.edit(
    Product(id: 2, name: "Samsung S24 Ultra", image: "", price: 2200),
  );

  var found = ProductRepository.find(2);
  print("\nFOUND:");
  print("${found?.name} - ${found?.price}");

  print("\nSEARCH 'iphone':");
  var searchResult = ProductRepository.search("iphone");
  searchResult.forEach((p) => print(p.name));

  ProductRepository.increasePrice10Percent();

  print("\n=== AFTER INCREASE 10% ===");
  ProductRepository.products.forEach((p) {
    print("${p.id} - ${p.name} - ${p.price}");
  });
}
