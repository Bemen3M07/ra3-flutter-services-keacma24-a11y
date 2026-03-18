import 'package:http/http.dart' as http;
import 'package:flutter_hello_world/models/cars_model.dart'; 

class CarHttpService {
  final String _serverUrl = "https://car-data.p.rapidapi.com";
  final String _headerKey = "7c00063cc0mshd06eb3f7234b024p167924jsn67c78b190f6a";
  final String _headerHost = "car-data.p.rapidapi.com";

  Future<List<CarsModel>> getCars() async {
    var uri = Uri.parse("$_serverUrl/cars");

    var response = await http.get(uri, headers: {
      "x-rapidapi-key": _headerKey,
      "x-rapidapi-host": _headerHost,
    });

    if (response.statusCode == 200) {
      return carsModelFromJson(response.body);
    } else {
      throw ("Error al obtener la lista de coches: ${response.statusCode}");
    }
  }
}