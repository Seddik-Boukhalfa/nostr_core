// ignore_for_file: non_constant_identifier_names

class Relay {
  static RegExp RELAY_URL_REGEX = RegExp(
      r'^(wss?:\/\/)([0-9]{1,3}(?:\.[0-9]{1,3}){3}|[^:]+):?([0-9]{1,5})?$');

  static String? clean(String adr) {
    if (adr.endsWith("/")) {
      adr = adr.substring(0, adr.length - 1);
    }
    if (adr.contains("%")) {
      adr = Uri.decodeComponent(adr);
    }
    adr = adr.trim();
    if (!adr.contains(RELAY_URL_REGEX)) {
      return null;
    }
    return adr;
  }
}
