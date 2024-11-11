import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class QuantityInputWidget extends StatefulWidget {
  final int stock; // Stock máximo disponible para el producto
  final String productName;
  final double price;
  

  const QuantityInputWidget({
    Key? key,
    required this.stock,
    required this.productName,
    required this.price,
  }) : super(key: key);

  @override
  _QuantityInputWidgetState createState() => _QuantityInputWidgetState();
}

class _QuantityInputWidgetState extends State<QuantityInputWidget> {
  final TextEditingController _controller = TextEditingController();
  int? quantity;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _addToCart() async {
    if (quantity == null || quantity! <= 0 || quantity! > widget.stock) {
      // Muestra alerta si la cantidad no es válida
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingrese una cantidad válida.')),
      );
      return;
    }

    // Obtén los productos almacenados en LocalStorage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartData = prefs.getString('cart');
    List<dynamic> cart = cartData != null ? jsonDecode(cartData) : [];

    // Revisa si el producto ya está en el carrito
    int productIndex = cart.indexWhere((item) => item['name'] == widget.productName);

    if (productIndex != -1) {
      // Si ya está, actualiza la cantidad y el total
      cart[productIndex]['quantity'] += quantity!;
      cart[productIndex]['total'] = cart[productIndex]['quantity'] * widget.price;
    } else {
      // Si no está y hay espacio, agrégalo al carrito
      if (cart.length < 7) {
        DateTime now = DateTime.now();
        cart.add({
          'name': widget.productName,
          'quantity': quantity!,
          'price': widget.price,
          'total': quantity! * widget.price,
          'date': now.toIso8601String(),
          
          
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Solo puedes agregar 7 productos diferentes.')),
        );
        return;
      }
    }

    // Guarda el carrito actualizado en LocalStorage
    await prefs.setString('cart', jsonEncode(cart));

    // Notifica que el producto fue agregado exitosamente
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Producto agregado al carrito.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Cantidad',
            hintText: 'Ingrese la cantidad',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              quantity = int.tryParse(value);
            });
          },
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            onPressed: _addToCart,
            child: const Text('Agregar al carrito'),
          ),
        ),
      ],
    );
  }
}
