import 'package:flutter/material.dart';
import 'database_helper.dart';

class QRCodeResultScreen extends StatelessWidget {
  final String codigo;

  const QRCodeResultScreen({super.key, required this.codigo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa da faculdade", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _getQRCodeData(codigo),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('QR Code não encontrado.',style: TextStyle(fontSize: 24),));
          } else {
            String imagePath = snapshot.data!['image'];
            return Center(
              child: Image.asset(imagePath),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>?> _getQRCodeData(String code) async {
    DatabaseHelper db = DatabaseHelper();
    return await db.getQRCode(code);
  }
}
