import 'taba_body_model.dart';

class TabaBlockModel {
  late Map<String, dynamic> header;
  late TabaBodyModel body;

  TabaBlockModel(
    this.header, {
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return {
      'header': header,
      'body': body.toJson(),
    };
  }
}