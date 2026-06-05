import '../../domain/entities/transaction_entity.dart';

/// MODELO DE DATOS (Data Layer)
/// Extiende de la entidad y añade lógica de serialización (JSON).
class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.id,
    required super.amount,
    required super.type,
    required super.category,
    required super.description,
    required super.date,
  });

  // Factory para crear instancia desde JSON (API response)
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id']?.toString() ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      type: json['type'] ?? 'expense',
      category: json['category'] ?? 'General',
      description: json['description'] ?? '',
      date: json['date'] != null 
          ? DateTime.parse(json['date']) 
          : DateTime.now(),
    );
  }

  // Método para convertir a JSON (Para POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'type': type,
      'category': category,
      'description': description,
      'date': date.toIso8601String(),
    };
  }
}
