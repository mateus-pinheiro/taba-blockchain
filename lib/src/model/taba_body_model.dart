import 'taba_transaction_model.dart';

const kApprovalPercentage = 0.51;

class TabaBodyModel {
  final List<TabaTransactionModel> transactions;
  final String projectId;
  final bool needsApproval;
  List<String>? approvers;

  TabaBodyModel(this.needsApproval, this.projectId,
      {required this.transactions, this.approvers});

  List<Map<String, dynamic>> toJson() {
    return transactions.map((transaction) => transaction.toJson()).toList();
  }

  bool isApproved(int totalInvolved) {
    return needsApproval
        ? (approvers!.length / totalInvolved) >= kApprovalPercentage
        : true;
  }
}
