// lib/repository/category_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dto/categories_response.dart';

class CategoryRepository {
  final String apiUrl = "https://dummyjson.com/products/categories";

  Future<List<Category>> fetchCategories() async {
    
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List categoriesJson = json.decode(response.body);
      return categoriesJson.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
