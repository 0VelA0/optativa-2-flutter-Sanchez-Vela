import 'package:flutter/material.dart';
import '../custom_textfield.dart';
import '../custom_buttom.dart';


class LoginInputs extends StatelessWidget {


  const LoginInputs({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    
    return Column(
      children: [
        
        const Padding(padding:EdgeInsets.all(10.0)),
        Customcaja(placeholder: "Ingresa tu usuario", controller: _usernameController),
        const Padding(padding:EdgeInsets.all(10.0)),
        Customcaja(placeholder: "Ingresa tu contraseña", controller: _passwordController),
        const Padding(padding:EdgeInsets.all(10.0)),
        CustomButtom(title: "Inicia sesion", icon: Icons.login, onClick:(){}),
      ],
    );
  }
}
