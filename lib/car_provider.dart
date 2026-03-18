import 'package:flutter/material.dart';
import 'models/cars_model.dart';
import 'services/car_http_service.dart';

class CarProvider extends ChangeNotifier {
  // Instancia del servicio que ya tienes creado
  final CarHttpService _service = CarHttpService();

  List<CarsModel> _cars = [];
  bool _isLoading = false;

  // Getters para acceder a los datos desde la UI
  List<CarsModel> get cars => _cars;
  bool get isLoading => _isLoading;

  // Método para cargar los coches
  Future<void> fetchCars() async {
    _isLoading = true;
    notifyListeners(); // Esto hace que aparezca el círculo de carga

    try {
      _cars = await _service.getCars();
    } catch (e) {
      debugPrint("Error al cargar coches: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // Esto dibuja la lista de coches cuando llegan
    }
  }
}