class Transaction {
  final String title;
  final double amount;
  final TransactionType type;
  final String description;
  final DateTime dateTime;

  Transaction({
    required this.title,
    required this.amount,
    required this.type,
    required this.description,
    required this.dateTime,
  });
}

enum TransactionType { income, outcome }
