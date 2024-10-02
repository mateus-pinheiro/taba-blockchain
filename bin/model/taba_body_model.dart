import 'taba_transaction_model.dart';

class TabaBodyModel {
  final List<TabaTransactionModel> transactions;

  TabaBodyModel({required this.transactions});

  List<Map<String, dynamic>> toJson() {
    return transactions.map((transaction) => transaction.toJson()).toList();
  }
}