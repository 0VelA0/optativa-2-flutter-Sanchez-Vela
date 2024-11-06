import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget{
  final String title;
  final IconData icon;
  final VoidCallback onClick;

  const CustomButtom({
    super.key,
    required this.title,
    required this.icon,
    required this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onClick,
      icon: Icon(icon),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 16)
      ),
    );
  }
}