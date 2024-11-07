import '../../../../infrastructure/connection/connection.dart';
import '../dto/categories_credentials.dart';

class CategoryRepository {
  Future<List<Category>> fetchCategories() async {
    String url = "https://dummyjson.com/products/categories";
    Connection connection = Connection();
    final response = await connection.get(url, headers: {
      'Content-Type': 'application/json',
    });

    List<dynamic> categoriesJson = response as List<dynamic>;
    
    return categoriesJson
        .map((name) => Category(name: name as String, icon: _getIconForCategory(name)))
        .toList();
  }

  // Método para asignar el icono (similar al de la clase Category)
  String _getIconForCategory(String name) {
    switch (name.toLowerCase()) {
      case 'beauty':
        return 'assets/icons/beauty.png';
      case 'electronics':
        return 'assets/icons/electronics.png';
      // Añade más categorías
      default:
        return 'assets/icons/default.png';
    }
  }
}

