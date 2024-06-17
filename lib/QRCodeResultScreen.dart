import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class QRCodeResultScreen extends StatefulWidget {
  final String codigo;

  const QRCodeResultScreen({super.key, required this.codigo});

  @override
  _QRCodeResultScreenState createState() => _QRCodeResultScreenState();
}

class _QRCodeResultScreenState extends State<QRCodeResultScreen> {
  Position? _currentPosition;
  late final String _imagePath;

  final double latMin = -23.564;
  final double latMax = -23.560;
  final double lonMin = -46.652;
  final double lonMax = -46.650;
  final double imgWidth = 1000; // Substitua pelo valor real da largura da imagem
  final double imgHeight = 1000; // Substitua pelo valor real da altura da imagem

  @override
  void initState() {
    super.initState();
    _imagePath = _getImagePath(widget.codigo);
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifique se os serviços de localização estão ativados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Serviços de localização não estão ativados, pode mostrar um alerta
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissões negadas, pode mostrar um alerta
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissões negadas permanentemente, pode mostrar um alerta
      return;
    }

    // Obtenha a localização atual do usuário
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });

    // Monitore a posição do usuário e atualize conforme ele se move
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _currentPosition = position;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa da faculdade", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: _imagePath.isNotEmpty
          ? Stack(
        children: [
          Center(child: Image.asset(_imagePath, fit: BoxFit.contain)),
          if (_currentPosition != null)
            Positioned(
              left: lonToPixel(_currentPosition!.longitude, imgWidth, lonMin, lonMax),
              top: latToPixel(_currentPosition!.latitude, imgHeight, latMin, latMax),
              child: const Icon(Icons.person_pin_circle, color: Colors.red, size: 40.0),
            ),
        ],
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
    switch (codigo) {
      case "0001":
        return 'assets/maps/mapa_1.png';
      case "0002":
        return 'assets/maps/mapa_2.png';
      default:
        return '';
    }
  }

  double latToPixel(double latitude, double imgHeight, double latMin, double latMax) {
    return imgHeight * (latitude - latMin) / (latMax - latMin);
  }

  double lonToPixel(double longitude, double imgWidth, double lonMin, double lonMax) {
    return imgWidth * (longitude - lonMin) / (lonMax - lonMin);
  }
}
