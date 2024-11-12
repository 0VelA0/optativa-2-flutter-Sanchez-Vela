import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../widgets/custom_appbar.dart';
import 'comprasfinalizadas.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Map<String, dynamic>> cartItems = [];
  double totalAmount = 0.0;

  Future<void> _clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');
    setState(() {
      cartItems = [];
      totalAmount = 0.0;
    });
  }

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
      });
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

  Future<void> _finalizePurchase() async {
    final prefs = await SharedPreferences.getInstance();
    final List<dynamic> completedPurchases = prefs.getString('purchases') != null
        ? jsonDecode(prefs.getString('purchases')!)
        : [];

    final newPurchase = {
      'totalAmount': totalAmount,
      'totalProducts': cartItems.length,
      'date': DateTime.now().toIso8601String(),
      'items': cartItems.map((item) => {
            'name': item['name'],
            'quantity': item['quantity'],
            'total': item['price'] * item['quantity'],
          }).toList(),
    };

    completedPurchases.add(newPurchase);
    await prefs.setString('purchases', jsonEncode(completedPurchases));
    await _clearCart();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CompletedPurchasesScreen()),
    );
  }

  void _viewCompletedPurchases() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CompletedPurchasesScreen()),
    );
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
                          leading: item['imageUrl'] != null
                              ? Image.network(
                                  item['imageUrl'],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : Icon(Icons.image_not_supported),
                          title: Text(
                            item['name'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Cantidad: ${item['quantity']}'),
                              Text('Precio: \$${item['price']}'),
                              Text('Total: \$${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              _removeItem(index);
                            },
                          ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: cartItems.isEmpty ? null : _finalizePurchase,
                        child: Text(
                          'Finalizar compra',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _viewCompletedPurchases,
                        child: Text(
                          'Compras realizadas',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
