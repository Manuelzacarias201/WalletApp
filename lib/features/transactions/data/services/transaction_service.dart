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

  /// Actualiza una transacción existente (PUT)
  Future<TransactionModel> updateTransaction(String id, TransactionModel transaction) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/transactions/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(transaction.toJson()),
      );

      if (response.statusCode == 200) {
        return TransactionModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al actualizar: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Elimina una transacción (DELETE)
  Future<void> deleteTransaction(String id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/transactions/$id'));

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Error al eliminar: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
