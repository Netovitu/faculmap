import 'package:flutter/material.dart';

class QRCodeResultScreen extends StatelessWidget {
  final String codigo;

  const QRCodeResultScreen({Key? key, required this.codigo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imagePath = _getImagePath(codigo);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa da faculdade", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: imagePath.isNotEmpty
          ? Center(
        child: Image.asset(imagePath, fit: BoxFit.contain),
      )
          : const Center(
        child: Text(
          'Mapa não encontrado',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  String _getImagePath(String codigo) {
    // Substitua este método pelo mapeamento real de códigos para imagens
    switch (codigo) {
      case "0001":
        return 'assets/maps/mapa_1.png';
      case "0002":
        return 'assets/maps/mapa_2.png';
    // Adicione mais casos conforme necessário
      default:
        return '';
    }
  }
}
