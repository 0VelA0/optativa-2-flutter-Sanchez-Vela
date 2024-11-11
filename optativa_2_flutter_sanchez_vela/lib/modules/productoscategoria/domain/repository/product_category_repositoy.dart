import '../../../../infrastructure/connection/connection.dart';
import '../dto/product_category_credentials.dart';
import '../../../login/domain/repository/authservice.dart';

class ProductRepository {
  final AuthService authService;

  ProductRepository(this.authService);

  Future<List<Product>> fetchProductsByCategory(String category) async {
    String url = "https://dummyjson.com/products/category/$category";

    // Obtiene el token del AuthService
    final token = await authService.getAuthToken();
    if (token == null) {
      throw Exception('No se encontró el token de autenticación');
    }

    Connection connection = Connection();
    final response = await connection.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Incluye el token en el encabezado
    });

    List productsJson = response['products'];
    return productsJson.map((item) => Product.fromJson(item)).toList();
  }
}
