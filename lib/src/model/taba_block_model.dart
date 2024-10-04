import 'taba_body_model.dart';
import 'taba_header_model.dart';

class TabaBlockModel {
  late TabaHeaderModel header;
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
