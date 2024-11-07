class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;
  final int stock;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.stock
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      thumbnail: json['thumbnail'],
      stock: json['stock']
    );
  }
}
