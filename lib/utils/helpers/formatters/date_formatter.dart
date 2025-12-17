import 'package:intl/intl.dart';

class DateFormatter {
  static const String _defaultFormat = 'dd.MM.yyyy';

  /// Parses a date from:
  ///  • ISO 8601 (e.g. "2025-09-16", "2025-09-16T10:20:30Z", "2025-09-16T10:20:30+05:00")
  ///  • "YYYY.MM.DD" (e.g. "2025.09.16")
  /// Returns a DateTime or throws FormatException if unsupported.
  /// Note:
  ///  - If the string has a 'Z' or timezone offset, the result is UTC.
  ///  - If it has no offset (e.g. "2025-09-16"), the result is local time at midnight.
  static DateTime parseDateAny(String input) {
    final s = input.trim();
    if (s.isEmpty) {
      throw const FormatException('Empty date string');
    }

    // 1) Try ISO 8601 (covers "YYYY-MM-DD" and full ISO strings)
    final iso = DateTime.tryParse(s);
    if (iso != null) return iso;

    // 2) Try dotted "YYYY.MM.DD"
    final dot = RegExp(r'^(\d{4})\.(\d{1,2})\.(\d{1,2})$').firstMatch(s);
    if (dot != null) {
      final y = int.parse(dot.group(1)!);
      final m = int.parse(dot.group(2)!);
      final d = int.parse(dot.group(3)!);
      return DateTime(y, m, d); // local midnight, validates ranges
    }

    // 3) Last-chance normalization: replace dots with dashes and retry parse
    final normalized = s.replaceAll('.', '-');
    final again = DateTime.tryParse(normalized);
    if (again != null) return again;

    throw FormatException('Unsupported date format: $input');
  }

  static String formatRecordListDate(DateTime? date) {
    if (date == null) {
      return 'No date available';
    }
    return DateFormat('MMMM d. y').format(date);
  }

  static String? formatDateForForm(DateTime? date) {
    //i want date to be returned as 9.9.2023
    if (date == null) {
      return null;
    }
    return '${date.day}.${date.month}.${date.year}';
  }

  /// Formats a DateTime to dd.MM.yyyy format
  static String formatDate(DateTime date) {
    return DateFormat(_defaultFormat).format(date);
  }

  /// Formats current date to dd.MM.yyyy format
  static String formatCurrentDate() {
    return formatDate(DateTime.now());
  }

  /// Formats a date to "dd MMM yyyy" format (e.g., "24 Aug 2025")
  static String formatDisplayDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  /// Formats a date string to dd.MM.yyyy format
  static String formatDateString(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return formatDate(date);
    } catch (e) {
      return dateString;
    }
  }

  /// Parses a date string in dd.MM.yyyy format to DateTime
  static DateTime? parseDate(String dateString) {
    try {
      return DateFormat(_defaultFormat).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Checks if a string is a valid date in dd.MM.yyyy format
  static bool isValidDate(String dateString) {
    return parseDate(dateString) != null;
  }

  /// Formats a timestamp to a relative time string (e.g., "5m ago", "2h ago", "now")
  static String formatMessageTimeStamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static String getMonthNameShort(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
