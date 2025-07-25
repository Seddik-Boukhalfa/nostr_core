import 'dart:math';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class StringUtil {
  static bool isNotBlank(String? str) {
    if (str != null && str != '') {
      return true;
    }
    return false;
  }

  static bool isBlank(String? str) {
    return !isNotBlank(str);
  }

  static String breakWord(String word) {
    if (word.isEmpty) {
      return word;
    }
    String breakWord = '';
    for (var element in word.runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }
    return breakWord;
  }

  static List<String> charByChar(String word) {
    // var runes = word.runes;
    // var length = runes.length;
    List<String> letters = [];
    for (var rune in word.runes) {
      var character = String.fromCharCode(rune);
      letters.add(character);
    }
    return letters;
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final _rnd = Random();

  static String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );

  static String formatTimeDifference(DateTime startDate) {
    Duration difference = DateTime.now().difference(startDate);

    int yearsDifference = difference.inDays ~/ 365;
    int monthsDifference = (difference.inDays % 365) ~/ 30;
    int daysDifference = difference.inDays % 30;
    int hoursDifference = difference.inHours % 24;
    int minutesDifference = difference.inMinutes % 60;

    if (yearsDifference > 0) {
      return '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
    } else if (monthsDifference > 0) {
      return '$monthsDifference ${_pluralize(monthsDifference, 'month')} ago';
    } else if (daysDifference > 0) {
      return '$daysDifference ${_pluralize(daysDifference, 'day')} ago';
    } else if (hoursDifference > 0) {
      return '$hoursDifference ${_pluralize(hoursDifference, 'hour')} ago';
    } else if (minutesDifference > 0) {
      return '$minutesDifference ${_pluralize(minutesDifference, 'minute')} ago';
    } else {
      return '< minute';
    }
  }

  static String getLastDate(DateTime lastMessageDate) {
    DateTime currentDateTime = DateTime.now();
    Duration difference = currentDateTime.difference(lastMessageDate);
    if (difference.inDays ~/ 365 > 0) {
      return '${difference.inDays ~/ 365}y';
    } else if (difference.inDays ~/ 30 > 0) {
      final months = difference.inDays ~/ 30;
      return '${months == 12 ? 11 : months}mo';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  static String _pluralize(int count, String unit) {
    return count == 1 ? unit : '${unit}s';
  }
}
