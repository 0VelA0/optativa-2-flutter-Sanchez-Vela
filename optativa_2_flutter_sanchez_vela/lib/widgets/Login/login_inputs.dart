import 'package:flutter/material.dart';
import '../custom_textfield.dart';
import '../custom_buttom.dart';
import '../../screens/categorias.dart';
import '../../modules/categories/useCase/category_usecase.dart';
import '../../modules/categories/domain/repository/category_repository.dart';

class LoginInputs extends StatelessWidget {
  const LoginInputs({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Column(
      children: [
        const Padding(padding: EdgeInsets.all(10.0)),
        Customcaja(placeholder: "Ingresa tu usuario", controller: usernameController),
        const Padding(padding: EdgeInsets.all(10.0)),
        Customcaja(placeholder: "Ingresa tu contraseña", controller: passwordController),
        const Padding(padding: EdgeInsets.all(10.0)),
        CustomButtom(
          title: "Inicia sesión", 
          icon: Icons.login, 
          onClick: () {
            final repository = CategoryRepository();
            final useCase = GetCategoriesUseCase(repository);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryScreen(getCategoriesUseCase: useCase)),
            );
          },
        ),
      ],
    );
  }
}
