// Servicio para llamadas a la API de TMB.
// Maneja requests HTTP para obtener datos de buses y paradas.

import 'dart:convert';
import 'package:http/http.dart' as http;

class TmbService {
  final String _appId = "a5cf0024";
  final String _appKey = "5c90f06469a5f45bca3f6c811cbca17f";
  final String _baseUrl = "https://api.tmb.cat/v1";

  // Obtiene tiempos de llegada de buses para una parada.
  Future<Map<String, dynamic>> getArrivalTimes(String stopCode) async {
    final url = Uri.parse('$_baseUrl/ibus/stops/$stopCode?app_id=$_appId&app_key=$_appKey');
    final response = await http.get(url);
    return json.decode(response.body);
  }

  // Obtiene información de una parada (nombre y dirección).
  Future<Map<String, dynamic>> getStopInfo(String stopCode) async {
    final url = Uri.parse('$_baseUrl/transit/parades/$stopCode?app_id=$_appId&app_key=$_appKey');
    final response = await http.get(url);
    return json.decode(response.body);
  }

  // Obtiene información de una línea de bus (para uso futuro).
  Future<Map<String, dynamic>> getLineInfo(String lineCode) async {
    final url = Uri.parse('$_baseUrl/transit/linies/bus/$lineCode?app_id=$_appId&app_key=$_appKey');
    final response = await http.get(url);
    return json.decode(response.body);
  }
}

