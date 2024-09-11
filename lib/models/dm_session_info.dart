class DMSessionInfo {
  final String id;
  final String peerPubkey;
  final String ownPubkey;
  final int readTime;

  DMSessionInfo({
    required this.id,
    required this.peerPubkey,
    required this.ownPubkey,
    required this.readTime,
  });
}
