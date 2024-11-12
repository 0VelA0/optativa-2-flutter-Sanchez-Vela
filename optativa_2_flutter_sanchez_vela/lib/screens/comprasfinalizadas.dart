import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../widgets/custom_appbar.dart';

class CompletedPurchasesScreen extends StatefulWidget {
  @override
  _CompletedPurchasesScreenState createState() => _CompletedPurchasesScreenState();
}

class _CompletedPurchasesScreenState extends State<CompletedPurchasesScreen> {
  List<Map<String, dynamic>> completedPurchases = [];

  @override
  void initState() {
    super.initState();
    _loadCompletedPurchases();
  }

  Future<void> _loadCompletedPurchases() async {
    final prefs = await SharedPreferences.getInstance();
    final String? purchasesData = prefs.getString('purchases');

    if (purchasesData != null) {
      setState(() {
        completedPurchases = List<Map<String, dynamic>>.from(json.decode(purchasesData));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Compras realizadas"),
      body: completedPurchases.isEmpty
          ? Center(
              child: Text(
                "No hay compras realizadas.",
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              itemCount: completedPurchases.length,
              itemBuilder: (context, index) {
                final purchase = completedPurchases[index];
                final purchaseDate = DateTime.parse(purchase['date']);
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(
                      'Compra del ${purchaseDate.day}/${purchaseDate.month}/${purchaseDate.year}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total: \$${purchase['totalAmount'].toStringAsFixed(2)}'),
                        Text('Total de productos: ${purchase['totalProducts']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
