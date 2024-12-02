class Productovistos {
  final String title;
  final double price;
  final String thumbnail;
  final int views;

  Productovistos({
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.views,
  });

  // Convertir el objeto a un mapa para almacenarlo como JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
      'views': views,
    };
  }

  // Crear un objeto a partir de un mapa JSON
  factory Productovistos.fromJson(Map<String, dynamic> json) {
    return Productovistos(
      title: json['title'],
      price: json['price'],
      thumbnail: json['thumbnail'],
      views: json['views'],
    );
  }
}
