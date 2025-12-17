import 'package:equatable/equatable.dart';

/// Model for multilingual content (English and Arabic)
class LocalizedTextModel extends Equatable {
  const LocalizedTextModel({
    required this.en,
    required this.ar,
  });

  factory LocalizedTextModel.fromJson(Map<String, dynamic> json) {
    return LocalizedTextModel(
      en: json['en'] as String? ?? '',
      ar: json['ar'] as String? ?? '',
    );
  }

  final String en;
  final String ar;

  Map<String, dynamic> toJson() => {
        'en': en,
        'ar': ar,
      };

  LocalizedTextModel copyWith({
    String? en,
    String? ar,
  }) {
    return LocalizedTextModel(
      en: en ?? this.en,
      ar: ar ?? this.ar,
    );
  }

  @override
  List<Object?> get props => [en, ar];

  @override
  String toString() => 'LocalizedTextModel(en: $en, ar: $ar)';
}
