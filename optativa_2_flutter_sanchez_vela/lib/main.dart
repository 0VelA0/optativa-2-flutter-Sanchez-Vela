import 'package:flutter/material.dart';
import 'router/list_routes.dart';
import 'router/routers.dart';
import 'package:localstorage/localstorage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final LocalStorage storage = LocalStorage('localstorage_app');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.red),
      ),
      initialRoute: Routers.login, // Definir la ruta inicial
      routes: ListRoutes.listScreens // Usar las rutas definidas en ListRouters
    );
  }
}
