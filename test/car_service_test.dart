import 'package:flutter_hello_world/services/car_http_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CarsApi', () {
    test('get cars', () async {
      // 1. Instanciamos el servicio que creaste
      final carHttpService = CarHttpService();
      
      // 2. Llamamos al método getCars y esperamos la respuesta [cite: 241, 272]
      final cars = await carHttpService.getCars();

      // 3. Verificamos que los resultados sean los esperados por la práctica:
      
      // Comprobamos que la lista tiene 10 elementos [cite: 273]
      expect(cars.length, 10);
      
      // Comprobamos que el ID del primer coche es 9582 [cite: 274]
      expect(cars[0].id, 9582);
      
      // Comprobamos que el ID del último coche es 9591 [cite: 275]
      expect(cars[9].id, 9591);
    });
  });
}
