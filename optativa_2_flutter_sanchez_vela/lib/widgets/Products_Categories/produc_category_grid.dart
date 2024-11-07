import 'package:flutter/material.dart';
import 'product_category_card.dart';
import '../../modules/productoscategoria/domain/dto/product_category_credentials.dart';
import '../../modules/productoscategoria/useCase/product_category_usecase.dart';

class ProductGrid extends StatefulWidget {
  final String category;

  const ProductGrid({Key? key, required this.category}) : super(key: key);

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  final ProductUseCase _productUseCase = ProductUseCase();
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _productUseCase.getProductsByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error al cargar productos: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay productos en esta categoría'));
        } else {
          final products = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index]);
            },
          );
        }
      },
    );
  }
}
