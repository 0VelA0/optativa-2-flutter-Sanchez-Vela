import 'package:flutter/material.dart';
import '../widgets/Products_Categories/header_pc.dart';
import '../widgets/Products_Categories/produc_category_grid.dart';
import '../widgets/custom_appbar.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;

  const CategoryProductsScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Porductos por categoria"),
      body: Column(
        children: [
          Headerpc(category: category),
          Expanded(child: ProductGrid(category: category)),
        ],
      ),
    );
  }
}
