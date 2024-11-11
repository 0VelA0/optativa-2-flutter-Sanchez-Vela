import 'package:flutter/material.dart';
import '../../router/routers.dart';

class Headerpc extends StatelessWidget {
  final String category;

  const Headerpc({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Categoría: $category',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, Routers.carritodecompras);
            },
          ),
        ],
      ),
    );
  }
}
