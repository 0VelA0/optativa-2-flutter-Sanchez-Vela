import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _userName;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  // Cargar el nombre del usuario desde SharedPreferences
  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('username'); // Recuperamos el nombre de usuario
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Perfil de usuario"),
      body: Center(  // Esto centra todo el contenido vertical y horizontal
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _userName == null
              ? const Center(child: CircularProgressIndicator()) // Cargando
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,  // Centra verticalmente
                  crossAxisAlignment: CrossAxisAlignment.center,  // Centra horizontalmente
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://dummyjson.com/icon/michaelw/128', // URL de la imagen
                      ),
                      radius: 80, // Radio de la imagen del perfil
                    ),
                    const SizedBox(height: 24), // Espacio entre la imagen y el nombre
                    Text(
                      _userName!,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16), // Espacio adicional debajo del nombre
                    ElevatedButton(
                      onPressed: () {
                        // Acción cuando se presiona el botón (puedes agregar más lógica aquí)
                      },
                      style: ElevatedButton.styleFrom(
                        iconColor: Colors.blueAccent, // Color del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Bordes redondeados
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 36),
                      ),
                      child: const Text(
                        'Editar perfil',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
