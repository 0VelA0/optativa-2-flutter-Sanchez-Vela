import '../domain/dto/product_category_credentials.dart';
import '../domain/repository/product_category_repositoy.dart';
import '../../login/domain/repository/authservice.dart';

class ProductUseCase {
  final ProductRepository _repository;

  // Constructor que recibe AuthService y lo pasa a ProductRepository
  ProductUseCase(AuthService authService) : _repository = ProductRepository(authService);

  Future<List<Product>> getProductsByCategory(String category) async {
    return await _repository.fetchProductsByCategory(category);
  }
}
