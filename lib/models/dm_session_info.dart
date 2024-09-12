// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  DMSessionInfo copyWith({
    String? id,
    String? peerPubkey,
    String? ownPubkey,
    int? readTime,
  }) {
    return DMSessionInfo(
      id: id ?? this.id,
      peerPubkey: peerPubkey ?? this.peerPubkey,
      ownPubkey: ownPubkey ?? this.ownPubkey,
      readTime: readTime ?? this.readTime,
    );
  }
}
