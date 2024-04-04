import 'package:intl/intl.dart';

extension type EventId(int eventId) {
  DateTime? toCreationDate() {
    try {
      // 2024010101235959 -> 2024-01-01 01:23:59
      if (eventId.toString().length == 14) {
        final year = int.parse(eventId.toString().substring(0, 4));
        final month = int.parse(eventId.toString().substring(4, 6));
        final day = int.parse(eventId.toString().substring(6, 8));
        final hour = int.parse(eventId.toString().substring(8, 10));
        final minute = int.parse(eventId.toString().substring(10, 12));
        final second = int.parse(eventId.toString().substring(12, 14));
        return DateTime(year, month, day, hour, minute, second);
      }
      return null;
    } on FormatException catch (_) {
      return null;
    }
  }

  static DateFormat get format => DateFormat('yyyyMMddHHmmss');
}
