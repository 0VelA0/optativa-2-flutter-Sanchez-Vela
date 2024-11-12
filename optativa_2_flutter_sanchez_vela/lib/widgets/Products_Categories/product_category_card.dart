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
          Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.network(
                widget.product.thumbnail,
                fit: BoxFit.cover,
                width: double.infinity,
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
            child: isOutOfStock || isCartFull
                ? Text(
                    "Producto agotado",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : CustomButtom(
                    title: "Detalles",
                    icon: Icons.details,
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            imageUrl: widget.product.thumbnail,
                            title: widget.product.title,
                            description: widget.product.description,
                            price: widget.product.price,
                            stock: widget.product.stock,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
        ],
      ),
    );
  }
}