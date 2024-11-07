import 'package:flutter/material.dart';

class PriceStockWidget extends StatelessWidget {
  final double price;
  final int stock;

  const PriceStockWidget({Key? key, required this.price, required this.stock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Precio \$${price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Stock $stock',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
