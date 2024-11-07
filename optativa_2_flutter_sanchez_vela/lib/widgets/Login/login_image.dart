import 'package:flutter/material.dart';

class LoginImage extends StatelessWidget {

  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pngwing.com%2Fes%2Fsearch%3Fq%3Diniciar%2Bsesi%25C3%25B3n&psig=AOvVaw3Es1Sa_XGNmFxOkbfme2d9&ust=1731002743822000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCJiq0u-lyIkDFQAAAAAdAAAAABAZ', // Reemplaza con el URL de tu imagen
          width: 150,
          height: 150,
        ),
      ],
    );
  }
}
