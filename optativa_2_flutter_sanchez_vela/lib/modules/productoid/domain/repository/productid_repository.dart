import '../../../../infrastructure/app/repository/repository.dart';
import '../../../../infrastructure/connection/connection.dart';
import '../dto/productid_credentials.dart';
import '../dto/productid_response.dart';

class ProductRepository implements Repository<ProductResponse, ProductId> {
  @override
  Future<ProductResponse> execute(ProductId params) async {
    String url = "https://dummyjson.com/products/${params.id}";
    Connection connection = Connection();
    final response = await connection.get(url, headers: {
      'Content-Type': 'application/json',
    });

    return ProductResponse.fromJson(response);
  }
}
