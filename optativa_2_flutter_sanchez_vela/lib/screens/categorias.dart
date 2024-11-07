import 'package:flutter/material.dart';
import 'package:optativa_2_flutter_sanchez_vela/widgets/custom_appbar.dart';
import '../modules/categories/domain/dto/categories_response.dart';
import '../modules/categories/useCase/category_usecase.dart';
import 'productos-por-categoria.dart'; // Importa la pantalla de productos por categoría

class CategoryScreen extends StatefulWidget {
  final GetCategoriesUseCase getCategoriesUseCase;

  const CategoryScreen({Key? key, required this.getCategoriesUseCase}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Category>> categoriesFuture;

  @override
  void initState() {
    super.initState();
    categoriesFuture = widget.getCategoriesUseCase.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Categorías"),
      body: FutureBuilder<List<Category>>(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay categorías disponibles'));
          } else {
            final categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return InkWell(
                  onTap: () {
                    // Navegar a la pantalla de productos de la categoría seleccionada
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryProductsScreen(category: category.name),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: category.url.isNotEmpty 
                        ? Image.network(category.url, width: 50, height: 50, fit: BoxFit.cover)
                        : Icon(Icons.image),
                    title: Text(category.name),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
