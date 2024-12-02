import 'package:flutter/material.dart';
import '../custom_buttom.dart';
import '../../screens/product-detallado.dart';
import '../../modules/productoscategoria/domain/dto/product_category_credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isOutOfStock = false;
  bool isCartFull = false;

  @override
  void initState() {
    super.initState();
    _checkCartStatus();
  }

  Future<void> _checkCartStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartData = prefs.getString('cart');
    List<dynamic> cart = cartData != null ? jsonDecode(cartData) : [];

    // Revisar si hay 7 productos en el carrito
    setState(() {
      isCartFull = cart.length >= 7;
    });

    // Buscar el producto en el carrito
    int productIndex = cart.indexWhere((item) => item['name'] == widget.product.title);

    if (productIndex != -1) {
      // Verificar si la cantidad en el carrito alcanza el stock
      int productQuantity = cart[productIndex]['quantity'];
      setState(() {
        isOutOfStock = productQuantity >= widget.product.stock;
      });
    }
  }

  Future<void> _registrarProductoVisto() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'productos_vistos';

    // Comprobar si existe la clave 'productos_vistos'
    if (prefs.containsKey(key)) {
      final String? data = prefs.getString(key);
      List<dynamic> productosVistos = data != null ? jsonDecode(data) : [];

      // Buscar si el producto ya fue visto
      int index = productosVistos.indexWhere((item) => item['title'] == widget.product.title);
      if (index != -1) {
        // Incrementar el contador de visitas
        productosVistos[index]['views'] += 1;
      } else {
        // Agregar un nuevo producto
        productosVistos.add({
          'title': widget.product.title,
          'price': widget.product.price,
          'thumbnail': widget.product.thumbnail,
          'views': 1,
        });
      }

      // Guardar la lista actualizada en SharedPreferences
      prefs.setString(key, jsonEncode(productosVistos));
    } else {
      // Si no existe la clave, inicializar el listado vacío y agregar el producto
      List<dynamic> productosVistos = [];
      productosVistos.add({
        'title': widget.product.title,
        'price': widget.product.price,
        'thumbnail': widget.product.thumbnail,
        'views': 1,
      });

      // Guardar la lista en SharedPreferences
      prefs.setString(key, jsonEncode(productosVistos));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.network(
                widget.product.thumbnail,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 50,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${widget.product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: isOutOfStock
                ? Text(
                    "Stock insuficiente",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : isCartFull
                    ? Text(
                        "Carrito lleno",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : CustomButtom(
                        title: "Detalles",
                        icon: Icons.details,
                        onClick: () async {
                          // Registrar el producto como visto
                          await _registrarProductoVisto();

                          // Navegar a la pantalla de detalles
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                imageUrl: widget.product.thumbnail,
                                title: widget.product.title,
                                description: widget.product.description,
                                price: widget.product.price,
                                stock: widget.product.stock,
                                productId: widget.product.id,
                              ),
                            ),
                          );
                        },
                      ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
