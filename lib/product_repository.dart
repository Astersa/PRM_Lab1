import 'product.dart';

class ProductRepository {
  static List<Product> products = [
    Product(id: 1, name: "iPhone 15", image: "", price: 2000),
    Product(id: 2, name: "Samsung S24", image: "", price: 1800),
    Product(id: 3, name: "Xiaomi 14", image: "", price: 1200),
  ];

  static void add(Product product) {
    products.add(product);
  }

  static void edit(Product updated) {
    int index = products.indexWhere((p) => p.id == updated.id);
    if (index != -1) {
      products[index] = updated;
    }
  }

  static Product? find(int id) {
    return products.firstWhere(
      (p) => p.id == id,
      orElse: () => Product(id: -1, name: "", image: "", price: 0),
    );
  }

  static List<Product> search(String keyword) {
    return products
        .where((p) => p.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  // declarative map
  static void increasePrice10Percent() {
    products = products
        .map((p) => Product(
              id: p.id,
              name: p.name,
              image: p.image,
              price: p.price * 1.1,
            ))
        .toList();
  }
}