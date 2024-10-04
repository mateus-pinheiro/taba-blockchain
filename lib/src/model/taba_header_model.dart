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
}
