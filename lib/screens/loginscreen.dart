import 'package:flutter/material.dart';

import '../widgets/Login/login_inputs.dart';
import '../widgets/custom_appbar.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:CustomAppBar(title: "Login") ,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            LoginInputs()
          ],
        ),
      ),
    );
  }
}
