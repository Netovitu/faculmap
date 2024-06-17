import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  const Buttons({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Center(
          child: Icon(icon, size: 106),
        ),
      ),
    );
  }
}
