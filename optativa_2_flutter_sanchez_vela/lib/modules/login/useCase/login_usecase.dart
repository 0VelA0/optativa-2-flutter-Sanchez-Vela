import '../../../infrastructure/app/use_case/use_case.dart';
import '../domain/dto/user_credentials.dart';
import '../domain/dto/user_login_response.dart';
import '../domain/repository/login_repository.dart';

class LoginUseCase implements UseCase<dynamic, UserCredentials> {
  @override
  Future<dynamic> execute(UserCredentials params) async {
    final UserCredentials credentials = UserCredentials(
      user: params.user,
      password: params.password,
    );

    final UserLoginResponse response =
        await LoginRepository().execute(credentials);
    return response;
  }
}
