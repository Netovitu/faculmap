import 'package:flutter/material.dart';

class QRCodeResultScreen extends StatelessWidget {
  final String codigo;

  const QRCodeResultScreen({super.key, required this.codigo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa da faculdade", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
      ),
      body: const Center(
        child: Text(
          'MAPA',
          style: TextStyle(fontSize: 58),
        ),
      ),
    );
  }
}
