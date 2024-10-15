// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class BaseEvent {}

class RemoteCacheEvent implements BaseEvent {
  final int kind;
  final String? subscriptionId;
  final Map<String, dynamic> data;

  factory RemoteCacheEvent.deserialize(dynamic input) {
    Map<String, dynamic> json = {};
    String? subscriptionId;

    subscriptionId = input[1];
    json = input[2];

    return RemoteCacheEvent(
      kind: json['kind'],
      subscriptionId: subscriptionId,
      data: json,
    );
  }

  RemoteCacheEvent({
    required this.kind,
    required this.data,
    this.subscriptionId,
  });
}
