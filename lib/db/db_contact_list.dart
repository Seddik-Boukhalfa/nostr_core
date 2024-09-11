import 'package:isar/isar.dart';
import 'package:nostr_core/models/contact_list.dart';

part 'db_contact_list.g.dart';

@Collection(inheritance: true)
class DbContactList extends ContactList {
  DbContactList({required super.pubkey, required super.contacts});

  String get id => pubkey;

  static DbContactList fromContactList(ContactList contactList) {
    DbContactList dbContactList = DbContactList(
      pubkey: contactList.pubkey,
      contacts: contactList.contacts,
    );
    dbContactList.createdAt = contactList.createdAt;
    dbContactList.loadedTimestamp = contactList.loadedTimestamp;
    dbContactList.sources = contactList.sources;
    dbContactList.followedCommunities = contactList.followedCommunities;
    dbContactList.followedTags = contactList.followedTags;
    dbContactList.followedEvents = contactList.followedEvents;
    dbContactList.contactRelays = contactList.contactRelays;
    dbContactList.petnames = contactList.petnames;
    return dbContactList;
  }
}
