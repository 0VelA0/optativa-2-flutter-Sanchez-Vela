import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../modules/categories/domain/dto/categories_response.dart';
import '../modules/categories/useCase/category_usecase.dart';
import '../router/routers.dart';
import '../widgets/custom_navigationbar.dart';
import '../screens/searchscreen.dart';
import '../screens/pvsscreen.dart';
import '../screens/perfilscreen.dart';

class CategoryScreen extends StatefulWidget {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryScreen({Key? key, required this.getCategoriesUseCase}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int _currentIndex = 0;

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchScreen()),
      );
    }
    if (index == 1){
      Navigator.pushNamed(context, Routers.carritodecompras);
    }
    if(index==2){
      Navigator.push(context,
       MaterialPageRoute(builder: (context)=> ProductosVistosScreen()));
    }
    if(index == 3){
      Navigator.push(context,
       MaterialPageRoute(builder: (context)=> ProfileScreen()));
    }
    // Agregar lógica para otras secciones
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Categorías"),
      body: FutureBuilder(
        future: widget.getCategoriesUseCase.execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
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
                      arguments: category.slug,
                    );
                  },
                );
              },
            );
          }

          return Center(child: Text("No hay categorías disponibles"));
        },
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}
