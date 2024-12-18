import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/Detalle_producto/productodetalle.dart';
import '../widgets/Detalle_producto/precioystock.dart';
import '../widgets/Detalle_producto/imagewidget.dart';
import '../widgets/Detalle_producto/verificadordecantidad.dart';
import '../widgets/Detalle_producto/reviewswidget.dart'; // Importa el nuevo widget de reviews

class ProductDetailScreen extends StatelessWidget {
  final int productId; // Cambiado para recibir el ID del producto
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final int stock;

  const ProductDetailScreen({
    Key? key,
    required this.productId,
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
            const Padding(padding: EdgeInsets.all(18.0)),
            ProductImageWidget(imageUrl: imageUrl),
            ProductDetailsWidget(title: title, description: description),
            PriceStockWidget(price: price, stock: stock),
            QuantityInputWidget(
              stock: stock,
              productName: title,
              price: price,
              imageUrl: imageUrl,
            ),
            ReviewsWidget(productId: productId), // Añadimos el widget aquí
          ],
        ),
      ),
    );
  }
}
