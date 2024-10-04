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

  Map<String, dynamic> toJson() {
    return {
      "timestamp": timestamp,
      "nonce": nonce,
      "hash": hash,
      "prevHash": prevHash
    };
  }
}
