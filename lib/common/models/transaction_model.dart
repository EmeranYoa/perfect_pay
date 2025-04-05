class Transaction {
  final String id;
  final String description;
  final DateTime date;
  final double amount;
  final bool isSent; // true for sent, false for received

  Transaction({
    required this.id,
    required this.description,
    required this.date,
    required this.amount,
    required this.isSent,
  });
}
