import 'package:nostr_core/nostr/event.dart';

abstract class EventFilter {
  bool filter(Event event);
}
