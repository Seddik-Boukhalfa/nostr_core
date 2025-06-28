import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WotCalculationData {
  final String pubkey;
  final Set<String> mutes;
  final Map<String, Set<String>> followings;
  final Set<String> contacts;

  WotCalculationData({
    required this.pubkey,
    required this.mutes,
    required this.followings,
    required this.contacts,
  });

  // Convert to JSON-compatible format
  Map<String, dynamic> toJson() {
    return {
      'pubkey': pubkey,
      'mutes': mutes,
      'followings': followings,
      'contacts': contacts,
    };
  }

  // Create from JSON-compatible format
  factory WotCalculationData.fromJson(Map<String, dynamic> json) {
    return WotCalculationData(
      pubkey: json['pubkey'] as String,
      mutes: Set<String>.from(json['mutes'] as List),
      followings: (json['followings'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, Set<String>.from(value as Set)),
      ),
      contacts: Set<String>.from(json['contacts'] as Set),
    );
  }
}

class WotModel {
  final String pubkey;
  final int createdAt;
  final Map<String, double> wot;

  WotModel({
    required this.pubkey,
    required this.createdAt,
    required this.wot,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pubkey': pubkey,
      'createdAt': createdAt,
      'wot': wot,
    };
  }

  factory WotModel.fromMap(Map<String, dynamic> map) {
    return WotModel(
      pubkey: map['pubkey'] as String,
      createdAt: map['createdAt'] as int,
      wot: Map<String, double>.from((map['wot'] as Map)),
    );
  }

  String toJson() => json.encode(toMap());

  factory WotModel.fromJson(String source) =>
      WotModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
