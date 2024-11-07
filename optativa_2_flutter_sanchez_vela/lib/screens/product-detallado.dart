import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/Detalle_producto/productodetalle.dart';
import '../widgets/Detalle_producto/precioystock.dart';
import '../widgets/custom_buttom.dart';

class ProductDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final int stock;

  const ProductDetailScreen({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Detalle producto"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductDetailsWidget(title: title, description: description),
            PriceStockWidget(price: price, stock: stock),
            CustomButtom(title: "regresar",
              icon: Icons.restore,
              onClick: () {
                // Acción del botón "Agregar"
                print('Producto agregado');
              },
            ),
          ],
        ),
      ),
    );
  }
}
