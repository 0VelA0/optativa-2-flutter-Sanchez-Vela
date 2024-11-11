import '../../../infrastructure/app/use_case/use_case.dart';
import '../domain/dto/user_credentials.dart';
import '../domain/dto/user_login_response.dart';
import '../domain/repository/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUseCase implements UseCase<dynamic, UserCredentials> {

  @override
  Future<dynamic> execute(UserCredentials params) async {
    final UserCredentials credentials = UserCredentials(
      user: params.user,
      password: params.password,
    );
    // Ejecuta el login y recibe la respuesta
    final UserLoginResponse response = await LoginRepository().execute(credentials);

    // Guarda el token en LocalStorage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', response.token);

    return response;
  }

  

}
