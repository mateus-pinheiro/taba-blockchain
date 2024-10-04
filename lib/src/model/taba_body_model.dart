import 'taba_transaction_model.dart';

const kApprovalPercentage = 0.51;

class TabaBodyModel {
  final List<TabaTransactionModel> transactions;
  final String projectId;
  final bool needsApproval;
  List<String>? approvers;

  TabaBodyModel(this.needsApproval, this.projectId,
      {required this.transactions, this.approvers});

  Map<String, dynamic> toJson() {
    return {
      "transactions":
          transactions.map((transaction) => transaction.toJson()).toList(),
      "projectId": projectId,
      "needsApproval": needsApproval,
      "approvers": approvers
    };
  }

  bool isApproved(int totalInvolved) {
    return needsApproval
        ? (approvers!.length / totalInvolved) >= kApprovalPercentage
        : true;
  }
}
