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

  bool isApproved() => needsApproval
      ? (approvers!.length / transactions.toList().length) >=
          kApprovalPercentage
      : true;
}
