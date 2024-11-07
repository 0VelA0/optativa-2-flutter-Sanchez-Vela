import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/Categories/categori_list.dart';
import '../modules/categories/useCase/category_usecase.dart';
import '../modules/categories/domain/dto/categories_credentials.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryUseCase categoryUseCase = CategoryUseCase();

    return Scaffold(
      appBar: const CustomAppBar(title: "Categorias"),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Category>>(
              future: categoryUseCase.execute(), // Llama al UseCase para obtener categorías
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar los datos'));
                } else {
                  final categories = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryItem(category: categories[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
