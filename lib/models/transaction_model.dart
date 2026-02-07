enum TransactionType {
  expense,
  income,
  pocketMoney,
}

class MoneyTransaction {
  final double amount;
  final String category;
  final String note;
  final DateTime date;
  final TransactionType type;

  MoneyTransaction({
    required this.amount,
    required this.category,
    required this.note,
    required this.date,
    required this.type,
  });
}

enum AnalysisRange {
  daily,
  weekly,
  monthly,
}


