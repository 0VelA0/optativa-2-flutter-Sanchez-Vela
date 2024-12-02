import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modules/productosvistos/dto/productosvistos_dto.dart';
import '../widgets/custom_appbar.dart';

class ProductosVistosScreen extends StatefulWidget {
  @override
  _ProductosVistosScreenState createState() => _ProductosVistosScreenState();
}

class _ProductosVistosScreenState extends State<ProductosVistosScreen> {
  late Future<List<Productovistos>> _productosVistos;

  @override
  void initState() {
    super.initState();
    _productosVistos = _obtenerProductosVistos();
  }

  Future<List<Productovistos>> _obtenerProductosVistos() async {
    final prefs = await SharedPreferences.getInstance();
    final productosJson = prefs.getString('productos_vistos');

    if (productosJson == null || productosJson.isEmpty) {
      return [];
    }

    final List<dynamic> decodedJson = jsonDecode(productosJson);
    return decodedJson.map((item) => Productovistos.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Porductos vistos"),
      body: FutureBuilder<List<Productovistos>>(
        future: _productosVistos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar los productos. Inténtalo más tarde.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final productos = snapshot.data ?? [];
          if (productos.isEmpty) {
            return Center(
              child: Text(
                'No hay productos vistos.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: ListTile(
                  title: Text(
                    producto.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Precio: \$${producto.price}\nVistas: ${producto.views}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
