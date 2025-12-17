enum Gender {
  male,
  female,
  other,
}

extension GenderExtension on Gender {
  /// Convert enum to API parameter name
  String get toApiName {
    switch (this) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
      case Gender.other:
        return 'other';
    }
  }

  /// Convert enum to display name
  String get toDisplayName {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.other:
        return 'Other';
    }
  }

  /// Convert API parameter name to enum
  static Gender fromApiName(String apiName) {
    switch (apiName) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      case 'other':
        return Gender.other;
      default:
        return Gender.male;
    }
  }

  /// Convert display name to enum
  static Gender fromDisplayName(String displayName) {
    switch (displayName) {
      case 'Male':
        return Gender.male;
      case 'Female':
        return Gender.female;
      case 'Other':
        return Gender.other;
      default:
        return Gender.male;
    }
  }

  /// Get all available filter options
  static List<String> get allOptions => [
        Gender.male.toDisplayName,
        Gender.female.toDisplayName,
        Gender.other.toDisplayName,
      ];
}
