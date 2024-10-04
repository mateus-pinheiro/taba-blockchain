class TabaTransactionModel {
  final String from;
  final String to;
  final int amount;

  TabaTransactionModel({
    required this.from,
    required this.to,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'amount': amount,
    };
  }
}