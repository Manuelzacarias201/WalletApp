import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transaction_model.dart';

/// SERVICIO HTTP (Data Layer)
/// Manejo exclusivo de la librería 'http' y códigos de estado.
class TransactionService {
  final String _baseUrl = 'https://api.fake-wallet.com'; // URL Base ficticia

  /// Obtiene la lista de transacciones (GET)
  Future<List<TransactionModel>> getTransactions() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/transactions'));

      // Manejo exhaustivo de Status Codes según rúbrica
      switch (response.statusCode) {
        case 200:
          final List<dynamic> data = json.decode(response.body);
          return data.map((item) => TransactionModel.fromJson(item)).toList();
        case 401:
          throw Exception('401: Sesión expirada o no autorizada');
        case 404:
          throw Exception('404: Recurso no encontrado en el servidor');
        case 500:
          throw Exception('500: Error interno del servidor');
        default:
          throw Exception('Error inesperado: ${response.statusCode}');
      }
    } catch (e) {
      // Re-lanzamos para que el ViewModel lo capture
      rethrow;
    }
  }

  /// Crea una nueva transacción (POST)
  Future<TransactionModel> createTransaction(TransactionModel transaction) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/transactions'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(transaction.toJson()),
      );

      if (response.statusCode == 201) {
        return TransactionModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 400) {
        throw Exception('400: Datos de transacción inválidos');
      } else {
        throw Exception('Error al crear transacción: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
