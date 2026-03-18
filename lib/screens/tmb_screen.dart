// Pantalla principal de la app TMB.
// Permite ingresar un ID de parada y muestra los buses que pasan.

import 'package:flutter/material.dart';
import '../controllers/tmb_controller.dart';
import '../models/tmb_bus_model.dart';

class TmbScreen extends StatefulWidget {
  @override
  _TmbScreenState createState() => _TmbScreenState();
}

class _TmbScreenState extends State<TmbScreen> {
  final TmbController _controller = TmbController();
  final TextEditingController _input = TextEditingController();
  
  List<BusArrival> _buses = [];
  StopData? _stopInfo;
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';

  void _consultar() async {
    String stopCode = _input.text.trim();
    if (stopCode.isEmpty) {
      _showError('Ingresa un código de parada');
      return;
    }
    if (!RegExp(r'^\d{2,5}$').hasMatch(stopCode)) {
      _showError('El código debe ser numérico de 2-5 dígitos');
      return;
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });

    final buses = await _controller.fetchArrivals(stopCode);
    final info = await _controller.fetchStopDetails(stopCode);

    if (info.name.startsWith('Parada ')) {
      _showError('Código de parada no encontrado');
      setState(() => _isLoading = false);
      return;
    }

    setState(() {
      _buses = buses;
      _stopInfo = info;
      _isLoading = false;
    });
  }

  void _showError(String message) {
    setState(() {
      _hasError = true;
      _errorMessage = message;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buscador de Paradas TMB'), backgroundColor: Colors.red),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _input,
              decoration: InputDecoration(
                labelText: 'Código de parada',
                suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: _consultar),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            if (_hasError) 
              Text(_errorMessage, style: TextStyle(color: Colors.red)),
            if (_stopInfo != null && !_hasError) ...[
              Text(_stopInfo!.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(_stopInfo!.address),
              Divider(),
            ],
            _isLoading 
              ? CircularProgressIndicator() 
              : Expanded(
                  child: ListView.builder(
                    itemCount: _buses.length,
                    itemBuilder: (context, index) {
                      final bus = _buses[index];
                      return ListTile(
                        leading: CircleAvatar(child: Text(bus.line)),
                        title: Text(bus.destination),
                        trailing: Text('${bus.minutes} min', style: TextStyle(color: Colors.red)),
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
