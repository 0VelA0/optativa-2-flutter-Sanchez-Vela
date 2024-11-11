class UserCredentials {
  final String user;
  final String password;


  UserCredentials({
    required this.user,
    required this.password,

  });

  factory UserCredentials.fromJson(Map<String, dynamic> json) {
    return UserCredentials(
      user: json['user'],
      password: json['password'] // Asegúrate de que 'token' coincida con el nombre en la respuesta de la API
    );
  }
}
