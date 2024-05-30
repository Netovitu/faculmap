import 'package:flutter/material.dart';
import 'package:facul_map/widgets/widget_button.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:facul_map/QRCodeResultScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String codigoLido = "0000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FACULMAP", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        actions: [IconButton(onPressed: () => (), icon: const Icon(
          Icons.location_on
        ), color: Colors.white,)],
      ),
      body: _leituras(),
    );
  }

  _leituras() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Buttons(icon: Icons.qr_code_scanner, onPressed: leituraQR,),
        ],
      ),
    );
  }

  Future<void> leituraQR() async {
    var res = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleBarcodeScannerPage(
          lineColor: "#ff0000",
          cancelButtonText: "Cancelar",
        ),
      ),
    );

    if (res is String) {
      setState(() {
        codigoLido = res;
      });

      // Navegar para tela do mapa.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRCodeResultScreen(codigo: codigoLido),
        ),
      );
    }
  }
}
