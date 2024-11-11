import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/categorias.dart';
import '../screens/productos-por-categoria.dart';
import '../screens/loginscreen.dart';
import '../screens/carritodecompras.dart';
import '../modules/categories/useCase/category_usecase.dart';
import 'routers.dart';

class ListRoutes {
  static final Map<String, Widget Function(BuildContext)> listScreens = {
    Routers.listadocategoria: (context) {
      final getCategoriesUseCase = Provider.of<GetCategoriesUseCase>(context);
      return CategoryScreen(getCategoriesUseCase: getCategoriesUseCase);
    },
    Routers.productoCategoria: (context) {
      final category = ModalRoute.of(context)!.settings.arguments as String;
      return CategoryProductsScreen(category: category);
    },
    Routers.login: (context) => const LoginScreen(),
    Routers.carritodecompras: (context) => ShoppingCartScreen(),
  };
}
