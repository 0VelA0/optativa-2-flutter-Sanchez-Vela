// lib/repository/category_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dto/categories_response.dart';
import '../../../login/domain/repository/authservice.dart';

class CategoryRepository {
  final String apiUrl = "https://dummyjson.com/products/categories";
  final AuthService authService;

  CategoryRepository(this.authService);

  Future<List<Category>> fetchCategories() async {
    // Obtén el token desde AuthService
    final token = await authService.getAuthToken();
    if (token == null) {
      throw Exception('No se encontró el token de autenticación');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Incluye el token en el encabezado
    };

    final response = await http.get(Uri.parse(apiUrl), headers: headers);

    if (response.statusCode == 200) {
      List categoriesJson = json.decode(response.body);
      return categoriesJson.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las categorías');
    }
  }
}
