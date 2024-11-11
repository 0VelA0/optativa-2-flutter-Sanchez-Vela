import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../widgets/custom_appbar.dart';


class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Map<String, dynamic>> cartItems = [];
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartData = prefs.getString('cart');

    if (cartData != null) {
      setState(() {
        cartItems = List<Map<String, dynamic>>.from(json.decode(cartData));
        totalAmount = _calculateTotalAmount();
        print(cartItems); // Depura la lista cargada para verificar
      });
    } else {
      print("No hay datos en SharedPreferences para 'cartItems'.");
    }
}

  double _calculateTotalAmount() {
    return cartItems.fold(0.0, (sum, item) {
      return sum + item['price'] * item['quantity'];
    });
  }

  void _removeItem(int index) async {
    setState(() {
      cartItems.removeAt(index);
      totalAmount = _calculateTotalAmount();
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cart', json.encode(cartItems));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Carrito de compras"),
      body: cartItems.isEmpty
          ? Center(
              child: Text(
                "No hay productos en el carrito.",
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: ListTile(
                          
                          leading: Text(
                            item['name'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            item['price'].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            item['quantity'].toString()
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              _removeItem(index);
                            },
                          ),
                          onTap: () {
                            // Aquí puedes navegar a la pantalla de detalles
                          },
                        ),
                      );
                    },
                  ),
                ),
                Divider(thickness: 1),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total a Pagar:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$${totalAmount.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Aquí puedes agregar la acción de pago o confirmación
                    },
                    child: Text(
                      'Proceder al Pago',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
