// lib/usecase/get_categories_usecase.dart
import '../domain/dto/categories_response.dart';
import '../domain/repository/category_repository.dart';


class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<Category>> execute() async {
    // Realiza la solicitud a la API, el token se gestiona internamente en CategoryRepository
    return await repository.fetchCategories();
  }
}
