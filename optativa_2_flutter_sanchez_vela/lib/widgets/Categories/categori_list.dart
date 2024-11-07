import 'package:flutter/material.dart';
import '../../modules/categories/domain/dto/categories_credentials.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.category, color: Colors.blue),
      title: Text(category.name),
      subtitle: Text(category.createdAt),
      trailing: Icon(Icons.arrow_forward, color: Colors.red),
    );
  }
}
