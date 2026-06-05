import 'package:flutter/material.dart';
import '../../data/models/transaction_model.dart';
import '../../data/services/transaction_service.dart';
import '../../domain/entities/transaction_entity.dart';

/// VIEWMODEL (Presentation Layer)
/// Expone el estado a la vista y gestiona la lógica de presentación.
class TransactionViewModel extends ChangeNotifier {
  // Inyección de dependencias manual por constructor
  final TransactionService _service;

  TransactionViewModel({required TransactionService service}) : _service = service;

  // Estados
  List<TransactionEntity> _transactions = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<TransactionEntity> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Lógica: Cargar transacciones
  Future<void> fetchTransactions() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _transactions = await _service.getTransactions();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Lógica: Actualizar transacción
  Future<void> updateTransaction(String id, TransactionModel tx) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _service.updateTransaction(id, tx);
      await fetchTransactions(); // Recargar lista
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Lógica: Eliminar transacción
  Future<void> deleteTransaction(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _service.deleteTransaction(id);
      _transactions.removeWhere((t) => t.id == id);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
