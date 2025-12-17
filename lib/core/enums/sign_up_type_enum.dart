import 'package:hive_flutter/adapters.dart';

part 'sign_up_type_enum.g.dart';

@HiveType(typeId: 0)
enum SignUpType {
  @HiveField(0)
  email,
  @HiveField(1)
  google,
  @HiveField(2)
  apple,
}

extension SignUpTypeExtensions on SignUpType {
  static const Map<SignUpType, String> _signUpTypeToString = {
    SignUpType.email: 'Email',
    SignUpType.google: 'Google',
    SignUpType.apple: 'Apple',
  };

  String get toName => _signUpTypeToString[this] ?? 'Email';

  static SignUpType fromString(String value) {
    final normalized = value.toLowerCase();

    return _signUpTypeToString.entries
        .firstWhere(
          (entry) => entry.value.toLowerCase() == normalized,
          orElse: () => const MapEntry(SignUpType.email, 'Email'),
        )
        .key;
  }
}
