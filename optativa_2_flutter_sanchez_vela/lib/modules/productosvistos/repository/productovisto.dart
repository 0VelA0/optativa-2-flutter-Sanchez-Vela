import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SeenProductService {
  final String _key = 'productos_vistos';

  Future<List<Map<String, dynamic>>> getProductosVistos() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(_key);
    if (data != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(data));
    } else {
      return [];
    }
  }

  Future<void> registrarProductoVisto(Map<String, dynamic> producto) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> productosVistos = await getProductosVistos();

    // Buscar si el producto ya fue visto
    int index = productosVistos.indexWhere((item) => item['title'] == producto['title']);
    if (index != -1) {
      // Incrementar el contador de visitas
      productosVistos[index]['views'] += 1;
    } else {
      // Agregar un nuevo producto
      productosVistos.add(producto);
    }

    // Guardar la lista actualizada en SharedPreferences
    prefs.setString(_key, jsonEncode(productosVistos));
  }
}
