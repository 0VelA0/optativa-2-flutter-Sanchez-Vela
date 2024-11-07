import 'package:flutter/material.dart';
import '../../modules/categories/domain/dto/categories_credentials.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final int index;

  CategoryItem({required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.category,
        color: index % 2 == 0 ? Colors.blue : Colors.red,
      ),
      title: Text(
        category.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("Fecha: ${DateTime.now()}"),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.redAccent),
      onTap: () {
        print("Seleccionaste la categoría ${category.name}");
      },
    );
  }
}
