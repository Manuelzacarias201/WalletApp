/// ENTIDAD LÓGICA (Domain Layer)
/// Representa el objeto de negocio puro sin dependencias de frameworks o JSON.
class TransactionEntity {
  final String id;
  final double amount;
  final String type; // 'income' | 'expense'
  final String category;
  final String description;
  final DateTime date;

  TransactionEntity({
    required this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.description,
    required this.date,
  });

  // Lógica de negocio simple dentro de la entidad
  bool get isIncome => type == 'income';
}
