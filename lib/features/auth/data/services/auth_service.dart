import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

/// SERVICIO DE AUTENTICACIÓN (Data Layer)
class AuthService {
  final String _baseUrl = 'https://api.fake-wallet.com/auth';

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      switch (response.statusCode) {
        case 200:
          return UserModel.fromJson(json.decode(response.body));
        case 401:
          throw Exception('Credenciales inválidas');
        case 404:
          throw Exception('Usuario no encontrado');
        case 500:
          throw Exception('Error en el servidor');
        default:
          throw Exception('Error inesperado: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return UserModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 400) {
        throw Exception('Datos de registro inválidos');
      } else {
        throw Exception('Error al registrar: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
