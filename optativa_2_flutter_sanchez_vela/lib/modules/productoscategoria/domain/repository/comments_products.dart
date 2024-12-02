import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchProductDetails(int productId) async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products/$productId'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load product details');
  }
}
