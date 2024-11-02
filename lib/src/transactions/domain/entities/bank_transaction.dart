class BankTransaction {
  final int? id;
  final String title;
  final double amount;
  final BankTransactionType type;
  final String description;
  final DateTime datetime;

  BankTransaction({
    this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.description,
    required this.datetime,
  });

  factory BankTransaction.fromJson(Map<String, dynamic> json) =>
      BankTransaction(
        id: json['id'],
        title: json['title'],
        amount: json['amount'],
        type: BankTransactionType.values[json['income']],
        description: json['description'],
        datetime: DateTime.parse(json['datetime']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'income': type.index,
        'description': description,
        'datetime': datetime.toIso8601String(),
      };
}

enum BankTransactionType { income, outcome }
