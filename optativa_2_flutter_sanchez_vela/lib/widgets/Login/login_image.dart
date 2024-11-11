import 'package:flutter/material.dart';

class LoginImage extends StatelessWidget {

  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: 
        Image.network(
          'https://dummyjson.com/icon/michaelw/128', //URL
          width: 150,
          height: 150,
        ),
    );
  }
}
