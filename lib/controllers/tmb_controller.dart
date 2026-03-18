// Controlador para la lógica de negocio de TMB.
// Conecta la UI con los servicios, procesando datos de la API.

import '../services/tmb_service.dart';
import '../models/tmb_bus_model.dart';

class TmbController {
  final TmbService _service = TmbService();

  // Obtiene la lista de buses que llegan a una parada.
  Future<List<BusArrival>> fetchArrivals(String stopCode) async {
    try {
      final response = await _service.getArrivalTimes(stopCode);
      List listado = response['data']['ibus'];
      return listado.map((item) => BusArrival.fromJson(item)).toList();
    } catch (e) {
      return [];
    }
  }

  // Obtiene información de la parada (nombre y dirección).
  Future<StopData> fetchStopDetails(String stopCode) async {
    try {
      final response = await _service.getStopInfo(stopCode);
      var props = response['features'][0]['properties'];
      return StopData(name: props['NOM_PARADA'], address: props['ADRECA']);
    } catch (e) {
      return StopData(name: "Parada $stopCode", address: "");
    }
  }
}

