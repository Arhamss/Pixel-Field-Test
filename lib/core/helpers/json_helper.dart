/// Helper class for safe JSON parsing and type casting
class JsonHelper {
  /// Safely cast dynamic value to Map<String, dynamic>
  /// Returns empty map if value is null or not a map
  static Map<String, dynamic> safeMapCast(dynamic value) {
    if (value == null) return {};
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return {};
  }

  /// Safely cast dynamic value to List<Map<String, dynamic>>
  /// Returns empty list if value is null or not a list
  static List<Map<String, dynamic>> safeListMapCast(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map(safeMapCast).toList();
    }
    return [];
  }

  /// Safely cast dynamic value to List<String>
  /// Returns empty list if value is null or not a list
  static List<String> safeStringListCast(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.cast<String>();
    }
    return [];
  }

  /// Safely cast dynamic value to String
  /// Returns empty string if value is null
  static String safeStringCast(dynamic value) {
    return value?.toString() ?? '';
  }

  /// Safely cast dynamic value to int
  /// Returns 0 if value is null or not a number
  static int safeIntCast(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  /// Safely cast dynamic value to double
  /// Returns 0.0 if value is null or not a number
  static double safeDoubleCast(dynamic value) {
    if (value == null) return 0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  /// Safely cast dynamic value to bool
  /// Returns false if value is null or not a boolean
  static bool safeBoolCast(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is String) {
      return value.toLowerCase() == 'true';
    }
    return false;
  }

  /// Safely parse DateTime from string
  /// Returns null if parsing fails
  static DateTime? safeDateTimeCast(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
