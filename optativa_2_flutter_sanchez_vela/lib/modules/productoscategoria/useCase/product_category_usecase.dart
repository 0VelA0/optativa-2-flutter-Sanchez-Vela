import '../domain/dto/product_category_credentials.dart';
import '../domain/repository/product_category_repositoy.dart';

class ProductUseCase {
  final ProductRepository _repository = ProductRepository();
  

  Future<List<Product>> getProductsByCategory(String category) async {
    return await _repository.fetchProductsByCategory(category);
  }
}
