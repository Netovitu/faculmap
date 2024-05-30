import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  const Buttons({super.key, required this.icon, required this.onPressed}); // Construtor

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6), // Radius
          ),
        ),
        child: Center(
          child: Icon(icon, size: 106), // Ícone centralizado
        ), // Substituindo o texto pelo ícone
      ),
    );
  }
}
