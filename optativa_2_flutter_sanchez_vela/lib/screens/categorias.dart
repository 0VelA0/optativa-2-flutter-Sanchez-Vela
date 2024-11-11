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
            // Comprobamos si el error es por la falta de autenticación
            if (snapshot.error.toString().contains("No estás autenticado")) {
              // Si no está autenticado, redirigimos a la pantalla de login
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, '/login');
              });
              return Center(child: Text("Redirigiendo a la pantalla de inicio de sesión..."));
            }

            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            List<Category> categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  title: Text(category.name),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routers.productoCategoria,
                      arguments: category.name,
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