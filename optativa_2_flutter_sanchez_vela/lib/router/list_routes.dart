import 'package:flutter/material.dart';
import '../screens/categorias.dart';
import 'routers.dart';
import '../screens/productos-por-categoria.dart';
import 'package:provider/provider.dart';
import '../modules/categories/useCase/category_usecase.dart';
import '../screens/loginscreen.dart';

// Definición de las rutas de la aplicación
class ListRoutes {
  static final Map<String, Widget Function(BuildContext)> listScreens = {
    Routers.listadocategoria: (context) {
      final getCategoriesUseCase = Provider.of<GetCategoriesUseCase>(context);
      return CategoryScreen(getCategoriesUseCase: getCategoriesUseCase);
    },
    Routers.productoCategoria: (context) {
      // Recuperamos los argumentos que se pasan con la ruta
      final category = ModalRoute.of(context)!.settings.arguments as String;

      // Devolvemos la pantalla de productos por categoría pasando la categoría seleccionada
      return CategoryProductsScreen(category: category);
    },
    Routers.login: (context) => const LoginScreen(),
  };
}
