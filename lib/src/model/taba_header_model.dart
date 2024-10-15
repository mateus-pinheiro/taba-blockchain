class TabaHeaderModel {
  String timestamp;
  int nonce;
  String hash;
  String prevHash;

  TabaHeaderModel(
      {required this.timestamp,
      required this.nonce,
      required this.hash,
      required this.prevHash});

  factory TabaHeaderModel.newEmpty() {
    return TabaHeaderModel(
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        hash: '',
        prevHash: '',
        nonce: 0);
  }

  factory TabaHeaderModel.fromJson(Map<String, dynamic> json) {
    return TabaHeaderModel(
      timestamp: json["timestamp"],
      hash: json["hash"],
      prevHash: json["prevHash"],
      nonce: json["nonce"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "timestamp": timestamp,
      "nonce": nonce,
      "hash": hash,
      "prevHash": prevHash
    };
  }
}
