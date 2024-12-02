import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../custom_textfield.dart';
import '../custom_buttom.dart';
import '../../screens/categorias.dart';
import '../../modules/categories/useCase/category_usecase.dart';
import '../../modules/categories/domain/repository/category_repository.dart';
import '../../modules/login/useCase/login_usecase.dart';
import '../../modules/login/domain/dto/user_credentials.dart';
import '../../modules/login/domain/repository/authservice.dart';
import '../Login/login_image.dart';

class LoginInputs extends StatelessWidget {
  const LoginInputs({super.key});

  // Función para limpiar los datos del carrito en SharedPreferences
  Future<void> _clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart'); // Elimina el carrito de SharedPreferences
  }

  // Función para guardar el nombre de usuario
  Future<void> _saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);  // Guarda el nombre de usuario
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Column(
      children: [
        const LoginImage(),
        const Padding(padding: EdgeInsets.all(18.0)),
        Customcaja(placeholder: "Ingresa tu usuario", controller: usernameController),
        const Padding(padding: EdgeInsets.all(10.0)),
        Customcaja(placeholder: "Ingresa tu contraseña", controller: passwordController),
        const Padding(padding: EdgeInsets.all(10.0)),
        CustomButtom(
          title: "Inicia sesión",
          icon: Icons.login,
          onClick: () async {
            final String user = usernameController.text;
            final String password = passwordController.text;

            // Llama al use case para ejecutar el login
            final loginUseCase = LoginUseCase();
            try {
              await loginUseCase.execute(
                UserCredentials(user: user, password: password),
              );

              // Limpia el carrito en SharedPreferences al iniciar sesión
              await _clearCart();

              // Guarda el nombre de usuario en SharedPreferences
              await _saveUsername(user);

              // Si el login fue exitoso, navega a la pantalla de categorías
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                    getCategoriesUseCase: GetCategoriesUseCase(CategoryRepository(AuthService())),
                  ),
                ),
              );
            } catch (e) {
              // Muestra un error si falla la autenticación
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error al iniciar sesión: $e')),
              );
            }
          },
        ),
      ],
    );
  }
}
