class Product {
  final int id;
  String name;
  String? image;
  double price;

  static List<Product> products = [
    Product(id: 1, name: "Teddy bear", image: "image.img", price: 120000),
    Product(id: 2, name: "Computer", image: "image.img", price: 390000),
    Product(id: 3, name: "Barbie Doll", image: "image.img", price: 90000),
    Product(id: 4, name: "Mobile", image: "image.img", price: 980000),
  ];

  factory Product.fromJson(Map<String, dynamic> json) {
    class Product {
      final int id;
      String name;
      String? image;
      double price;

      static List<Product> products = [
        Product(id: 1, name: 'Teddy bear', image: 'image.img', price: 120000),
        Product(id: 2, name: 'Computer', image: 'image.img', price: 390000),
        Product(id: 3, name: 'Barbie Doll', image: 'image.img', price: 90000),
        Product(id: 4, name: 'Mobile', image: 'image.img', price: 980000),
      ];

      Product({
        required this.id,
        required this.name,
        this.image,
        required this.price,
      });

      factory Product.fromJson(Map<String, dynamic> json) {
        return Product(
          id: json['id'] is int ? json['id'] as int : int.parse(json['id'].toString()),
          name: json['name'].toString(),
          image: json['image']?.toString(),
          price: (json['price'] as num).toDouble(),
        );
      }

      static void add(Product p) => products.add(p);

      static void editById(int id, {String? name, String? image, double? price}) {
        final i = products.indexWhere((e) => e.id == id);
        if (i == -1) return;
        final current = products[i];
        products[i] = Product(
          id: current.id,
          name: name ?? current.name,
          image: image ?? current.image,
          price: price ?? current.price,
        );
      }

      static bool deleteById(int id) {
        final i = products.indexWhere((e) => e.id == id);
        if (i == -1) return false;
        products.removeAt(i);
        return true;
      }

      // Search by name (case-insensitive)
      static List<Product> searchByName(String q) {
        final ql = q.toLowerCase();
        return products.where((e) => e.name.toLowerCase().contains(ql)).toList();
      }

      static Product? findById(int id) {
        try {
          return products.firstWhere((e) => e.id == id);
        } catch (_) {
          return null;
        }
      }

      static void increasePricesBy10Percent() {
        products = products
            .map((e) => Product(id: e.id, name: e.name, image: e.image, price: (e.price * 1.1).roundToDouble()))
            .toList();
      }

      static void sortByPrice({bool ascending = true}) {
        products.sort((a, b) => ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
      }

      @override
      String toString() => 'Product(id: $id, name: $name, price: $price, image: $image)';

      static void printAll() => products.forEach((p) => print(p));
    }

  }

  static void sortByPrice({bool ascending = true}) {
    products.sort((a, b) => ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
  }

  List<Product> getListProduct() => products;

  void printProduct() {
    print(
      'product id: ${this.id}, product name: ${this.name}, product price: ${this.price}, product image: ${this.image}',
    );
  }

  void printListProduct() {
    products.forEach(
      (e) => print(
        'product id: ${e.id}, product name: ${e.name}, product price: ${e.price}, product image: ${e.image}',
      ),
    );
  }
}
