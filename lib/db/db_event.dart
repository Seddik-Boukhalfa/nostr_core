// ignore_for_file: unnecessary_overrides, invalid_annotation_target

import 'package:isar/isar.dart';
import 'package:nostr_core/nostr/event.dart';

part 'db_event.g.dart';

@Collection(inheritance: false)
class DbEvent extends Event {
  DbEvent(
    super.id,
    super.pubkey,
    super.createdAt,
    super.kind,
    super.tags,
    super.content,
    super.sig, {
    super.currentUser,
    super.seenOn,
    super.lastUpdated,
  });

  @override
  String get id => super.id;

  @override
  String get pubkey => super.pubkey;

  @override
  int get kind => super.kind;

  @override
  int get createdAt => super.createdAt;

  @override
  List<dynamic> get tags => super.tags;

  @override
  String get content => super.content;

  @override
  List<String> get seenOn => super.seenOn;

  @override
  String get currentUser => super.currentUser;

  int? get lastUpdate => super.lastUpdated;

  @override
  @embedded
  String get sig => super.sig;

  @override
  String? get dTag {
    List<String> dTags = super.stTags.where((element) {
      List<dynamic> a = element;
      if (a.isNotEmpty && a.first.toString() == "d") {
        return true;
      }

      return false;
    }).map((e) {
      List<dynamic> list = e;
      return list.length == 2 ? list[1].toString() : "";
    }).toList();

    return dTags.isEmpty ? null : dTags.first;
  }

  @override
  List<String> get pTags {
    List<String> pTags = super.stTags.where((element) {
      List<dynamic> a = element;
      if (a.isNotEmpty && a.first.toString() == "p") {
        return true;
      }

      return false;
    }).map((e) {
      List<dynamic> list = e;
      return list.length == 2 ? list[1].toString() : "";
    }).toList();

    return pTags;
  }

  @override
  List<String> get eTags {
    List<String> eTags = super.stTags.where((element) {
      List<dynamic> a = element;
      if (a.isNotEmpty && a.first.toString() == "e") {
        return true;
      }

      return false;
    }).map((e) {
      List<dynamic> list = e;
      return list.length >= 2 ? list[1].toString() : "";
    }).toList();

    return eTags;
  }

  @override
  String? get root {
    List<String> roots = super.stTags.where((element) {
      List<String> a = element;
      if (a.isNotEmpty && a.first.toString() == "e") {
        return true;
      }

      return false;
    }).map((e) {
      List<String> list = e;
      return list.length > 3 && list[3] == 'root' ? list[1].toString() : "";
    }).toList();

    return roots.isEmpty ? null : roots.first;
  }

  @override
  String? get reply {
    List<String> replies = super.stTags.where((element) {
      List<String> a = element;
      if (a.isNotEmpty && a.first.toString() == "e") {
        return true;
      }

      return false;
    }).map((e) {
      List<String> list = e;
      return list.length > 3 && list[3] == 'reply' ? list[1].toString() : "";
    }).toList();

    return replies.isEmpty ? null : replies.first;
  }

  static DbEvent fromEvent(Event event) {
    DbEvent dbEvent = DbEvent(
      event.id,
      event.pubkey,
      event.createdAt,
      event.kind,
      event.tags,
      event.content,
      event.sig,
      currentUser: event.currentUser,
      seenOn: event.seenOn,
      lastUpdated: event.lastUpdated,
    );

    return dbEvent;
  }
}
