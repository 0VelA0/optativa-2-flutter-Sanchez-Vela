import '../../../../infrastructure/app/repository/repository.dart';
import '../../../../infrastructure/connection/connection.dart';
import '../dto/user_credentials.dart';
import '../dto/user_login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository implements Repository<UserLoginResponse, UserCredentials> {

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
  return prefs.getString('authToken');
}


  @override
  Future<UserLoginResponse> execute(UserCredentials params) async {
    final data = {
      "username": params.user,
      "password": params.password,
      "expiresInMins": 30,
    };
    String url = "https://dummyjson.com/auth/login";
    Connection connection = Connection();

    // Obtiene el token del LocalStorage
    final token = await getAuthToken();

    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await connection.post(url, data, headers: headers);

    return UserLoginResponse.fromJson(response);
  }
}

