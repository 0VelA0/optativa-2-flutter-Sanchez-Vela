import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Obtener el token de SharedPreferences
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  // Verificar si el usuario está autenticado
  Future<bool> isLoggedIn() async {
    final token = await getAuthToken();
    return token != null;
  }

  // Obtener el token o lanzar una excepción si no está autenticado
  Future<String> getAuthTokenOrThrow() async {
    final token = await getAuthToken();
    if (token == null) {
      throw Exception("No estás autenticado. Inicia sesión para continuar.");
    }
    return token;
  }
  //eliminar token del local storage 
  Future<void> removeAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }
}
