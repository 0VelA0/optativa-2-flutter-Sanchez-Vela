import 'package:flutter/material.dart';

class Customcaja extends StatelessWidget{
  final String placeholder;
  final TextEditingController controller;

  const Customcaja({super.key,
  required this.placeholder,
  required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: placeholder
      ),
    );
  }
}