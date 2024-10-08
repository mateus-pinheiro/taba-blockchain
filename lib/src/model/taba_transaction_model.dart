class TabaTransactionModel {
  final String timestamp;
  final String from;
  final String userId;
  final int amount;

  TabaTransactionModel({
    required this.timestamp,
    required this.from,
    required this.userId,
    required this.amount,
  });

  factory TabaTransactionModel.fromJson(Map<String, dynamic> json) {
    return TabaTransactionModel(
        timestamp: json["timestamp"],
        from: json["from"],
        userId: json["userId"],
        amount: json["amount"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'userId': userId,
      'amount': amount,
    };
  }
}
