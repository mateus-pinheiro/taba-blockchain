import 'taba_body_model.dart';
import 'taba_header_model.dart';

class TabaBlockModel {
  late TabaHeaderModel header;
  late TabaBodyModel body;

  TabaBlockModel(
    this.header, {
    required this.body,
  });

  factory TabaBlockModel.fromJson(Map<String, dynamic> json) {
    return TabaBlockModel(TabaHeaderModel.fromJson(json['header']),
        body: TabaBodyModel.fromJson(json['body']));
  }

  Map<String, dynamic> toJson() {
    return {
      'header': header.toJson(),
      'body': body.toJson(),
    };
  }
}
