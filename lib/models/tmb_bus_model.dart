// Modelos de datos para la app TMB.
// Representan la estructura de los datos usados en la aplicación.

// Modelo para la llegada de un bus a una parada.
class BusArrival {
  final String line; // Código de la línea del bus
  final String destination; // Destino del bus
  final String minutes; // Minutos hasta la llegada

  BusArrival({required this.line, required this.destination, required this.minutes});

  // Crea una instancia desde JSON de la API.
  factory BusArrival.fromJson(Map<String, dynamic> json) {
    return BusArrival(
      line: json['line'] ?? '?',
      destination: json['destination'] ?? 'Desconocido',
      minutes: json['t-in-min']?.toString() ?? '?',
    );
  }
}

// Modelo para información de una parada de bus.
class StopData {
  final String name; // Nombre de la parada
  final String address; // Dirección de la parada

  StopData({required this.name, required this.address});
}

