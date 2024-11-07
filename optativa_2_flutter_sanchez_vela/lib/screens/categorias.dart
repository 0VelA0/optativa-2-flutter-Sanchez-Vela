import 'package:flutter/material.dart';
import '../modules/categories/useCase/category_usecase.dart';
import '../modules/categories/domain/dto/categories_credentials.dart';
import '../widgets/custom_appbar.dart';

import '../screens/productos-por-categoria.dart'; // Importa la pantalla de productos por categoría


class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<Category>> _categoriesFuture;
  final CategoryUseCase _categoryUseCase = CategoryUseCase();

  @override
  void initState() {
    super.initState();
    //_categoriesFuture = _categoryUseCase.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Categorías"),
      body: FutureBuilder<List<Category>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No se encontraron categorías.'));
          } else {
            final categories = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  title: Text(
                    category.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    // Navega a la pantalla de productos por categoría al hacer clic
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryProductsScreen(
                          category: category.name, // Pasa el nombre de la categoría
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
