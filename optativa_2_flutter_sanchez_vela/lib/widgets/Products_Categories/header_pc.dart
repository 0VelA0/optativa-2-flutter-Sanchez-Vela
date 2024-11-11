import 'package:flutter/material.dart';
import '../../router/routers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Headerpc extends StatelessWidget {
  final String category;

  const Headerpc({Key? key, required this.category}) : super(key: key);

  Future<void> borrartoken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); 
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
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
