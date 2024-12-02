import 'dart:convert';
import 'package:optativa_2_flutter_sanchez_vela/modules/productosvistos/dto/productosvistos_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductosService {
  static const _keyProductosVistos = 'productos_vistos';

  static Future<void> registrarProductoVisto(Productovistos producto) async {
    final prefs = await SharedPreferences.getInstance();
    final productosJson = prefs.getStringList(_keyProductosVistos) ?? [];
    final productos = productosJson.map((p) => Productovistos.fromMap(jsonDecode(p))).toList();

    // Buscar si el producto ya existe
    final index = productos.indexWhere((p) => p.nombre == producto.nombre);
    if (index != -1) {
      productos[index].visitas += 1; // Incrementar visitas
    } else {
      productos.add(producto);
    }

    // Guardar de nuevo en localStorage
    final nuevosProductosJson = productos.map((p) => jsonEncode(p.toMap())).toList();
    await prefs.setStringList(_keyProductosVistos, nuevosProductosJson);
  }

  static Future<List<Productovistos>> obtenerProductosVistos() async {
    final prefs = await SharedPreferences.getInstance();
    final productosJson = prefs.getStringList(_keyProductosVistos) ?? [];
    return productosJson.map((p) => Productovistos.fromMap(jsonDecode(p))).toList();
  }
}
