import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../modules/categories/domain/dto/categories_response.dart';
import '../modules/categories/useCase/category_usecase.dart';
import '../router/routers.dart';

class CategoryScreen extends StatelessWidget {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryScreen({Key? key, required this.getCategoriesUseCase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Categorías"),
      body: FutureBuilder(
        future: getCategoriesUseCase.execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            List<Category> categories = snapshot.data!; // Asegúrate de que tu clase Category esté bien definida
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  title: Text(category.name),
                  onTap: () {
                    // En lugar de Navigator.push, usamos pushNamed
                    Navigator.pushNamed(
                      context,
                      Routers.productoCategoria, // Ruta definida en ListRoutes
                      arguments: category.name,  // Pasamos la categoría como argumento
                    );
                  },
                );
              },
            );
          }
          return Center(child: Text("No hay categorías disponibles"));
        },
      ),
    );
  }
}
