import '../../../../infrastructure/connection/connection.dart';
import '../dto/product_category_credentials.dart';

class ProductRepository {
  Future<List<Product>> fetchProductsByCategory(String category) async {
    String url = "https://dummyjson.com/products/category/$category";
    Connection connection = Connection();
    final response = await connection.get(url, headers: {
      'Content-Type': 'application/json',
    });

    List productsJson = response['products'];
    return productsJson.map((item) => Product.fromJson(item)).toList();
  }
}
