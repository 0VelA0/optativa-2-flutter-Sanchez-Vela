import '../../../../infrastructure/connection/connection.dart';
import '../dto/categories_credentials.dart';

class CategoryRepository {
  Future<List<Category>> fetchCategories() async {
    String url = "https://dummyjson.com/products/categories";
    Connection connection = Connection();
    final response = await connection.get(url, headers: {
      'Content-Type': 'application/json',
    });

    return (response as List).map((item) => Category.fromJson(item)).toList();
  }
}
