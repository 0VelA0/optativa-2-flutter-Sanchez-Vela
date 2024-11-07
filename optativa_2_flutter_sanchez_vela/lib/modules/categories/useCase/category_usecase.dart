import '../domain/dto/categories_credentials.dart';
import '../domain/repository/category_repository.dart';

class CategoryUseCase {
  final CategoryRepository _repository = CategoryRepository();

  Future<List<Category>> execute() async {
    return await _repository.fetchCategories();
  }
}
