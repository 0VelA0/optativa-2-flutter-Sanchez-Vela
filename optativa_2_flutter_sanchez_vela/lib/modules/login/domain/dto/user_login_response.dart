class UserLoginResponse {

  final String token;


  UserLoginResponse({

    required this.token,

  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginResponse(

      token: json["accessToken"],

    );
  }
}
