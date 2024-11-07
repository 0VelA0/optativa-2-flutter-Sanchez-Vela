import 'package:flutter/material.dart';
import 'screens/productos-por-categoria.dart';
import 'screens/categorias.dart';
import 'screens/product-detallado.dart';
import 'screens/loginscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CategoryProductsScreen(category: "smartphones",)
    );
  }
}
