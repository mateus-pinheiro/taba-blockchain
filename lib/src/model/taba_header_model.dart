class TabaHeaderModel {
  int timestamp;
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
        timestamp: DateTime.now().millisecondsSinceEpoch,
        hash: '',
        prevHash: '',
        nonce: 0);
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
