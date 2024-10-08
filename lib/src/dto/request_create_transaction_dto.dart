import 'package:taba_blockchain/src/model/taba_transaction_model.dart';

class RequestCreateTransactionDto {
  String projectId;
  TabaTransactionModel transaction;

  RequestCreateTransactionDto(this.projectId, this.transaction);

  factory RequestCreateTransactionDto.fromJson(Map<String, dynamic> json) {
    return RequestCreateTransactionDto(
        json["projectId"], TabaTransactionModel.fromJson(json["transaction"]));
  }
}
