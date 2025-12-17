import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.name,
    required this.age,
    required this.caskNumber,
    required this.bottleNumber,
    required this.totalBottles,
    required this.distillery,
    required this.region,
    required this.country,
    required this.type,
    required this.ageStatement,
    required this.filledDate,
    required this.bottledDate,
    required this.abv,
    required this.size,
    required this.finish,
    required this.collectionName,
    required this.imageUrl,
    required this.status,
    this.tastingNotes,
    this.history,
    this.videoId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      caskNumber: json['cask_number'] as String,
      bottleNumber: json['bottle_number'] as int,
      totalBottles: json['total_bottles'] as int,
      distillery: json['distillery'] as String,
      region: json['region'] as String,
      country: json['country'] as String,
      type: json['type'] as String,
      ageStatement: json['age_statement'] as String,
      filledDate: json['filled_date'] as String,
      bottledDate: json['bottled_date'] as String,
      abv: json['abv'] as String,
      size: json['size'] as String,
      finish: json['finish'] as String,
      collectionName: json['collection_name'] as String,
      imageUrl: json['image_url'] as String,
      status: BottleStatus.fromString(json['status'] as String),
      tastingNotes: json['tasting_notes'] != null
          ? TastingNotesModel.fromJson(
              json['tasting_notes'] as Map<String, dynamic>,
            )
          : null,
      history: json['history'] != null
          ? (json['history'] as List<dynamic>)
              .map(
                (e) => HistoryItemModel.fromJson(e as Map<String, dynamic>),
              )
              .toList()
          : null,
      videoId: json['video_id'] as String?,
    );
  }

  final String id;
  final String name;
  final int age;
  final String caskNumber;
  final int bottleNumber;
  final int totalBottles;
  final String distillery;
  final String region;
  final String country;
  final String type;
  final String ageStatement;
  final String filledDate;
  final String bottledDate;
  final String abv;
  final String size;
  final String finish;
  final String collectionName;
  final String imageUrl;
  final BottleStatus status;
  final TastingNotesModel? tastingNotes;
  final List<HistoryItemModel>? history;
  final String? videoId;

  String get displayName => '$name $age Year old';
  String get bottleInfo => 'Bottle $bottleNumber/$totalBottles';

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'cask_number': caskNumber,
        'bottle_number': bottleNumber,
        'total_bottles': totalBottles,
        'distillery': distillery,
        'region': region,
        'country': country,
        'type': type,
        'age_statement': ageStatement,
        'filled_date': filledDate,
        'bottled_date': bottledDate,
        'abv': abv,
        'size': size,
        'finish': finish,
        'collection_name': collectionName,
        'image_url': imageUrl,
        'status': status.value,
        'tasting_notes': tastingNotes?.toJson(),
        'history': history?.map((e) => e.toJson()).toList(),
        'video_id': videoId,
      };

  ProductModel copyWith({
    String? id,
    String? name,
    int? age,
    String? caskNumber,
    int? bottleNumber,
    int? totalBottles,
    String? distillery,
    String? region,
    String? country,
    String? type,
    String? ageStatement,
    String? filledDate,
    String? bottledDate,
    String? abv,
    String? size,
    String? finish,
    String? collectionName,
    String? imageUrl,
    BottleStatus? status,
    TastingNotesModel? tastingNotes,
    List<HistoryItemModel>? history,
    String? videoId,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      caskNumber: caskNumber ?? this.caskNumber,
      bottleNumber: bottleNumber ?? this.bottleNumber,
      totalBottles: totalBottles ?? this.totalBottles,
      distillery: distillery ?? this.distillery,
      region: region ?? this.region,
      country: country ?? this.country,
      type: type ?? this.type,
      ageStatement: ageStatement ?? this.ageStatement,
      filledDate: filledDate ?? this.filledDate,
      bottledDate: bottledDate ?? this.bottledDate,
      abv: abv ?? this.abv,
      size: size ?? this.size,
      finish: finish ?? this.finish,
      collectionName: collectionName ?? this.collectionName,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      tastingNotes: tastingNotes ?? this.tastingNotes,
      history: history ?? this.history,
      videoId: videoId ?? this.videoId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        caskNumber,
        bottleNumber,
        totalBottles,
        distillery,
        region,
        country,
        type,
        ageStatement,
        filledDate,
        bottledDate,
        abv,
        size,
        finish,
        collectionName,
        imageUrl,
        status,
        tastingNotes,
        history,
        videoId,
      ];
}

enum BottleStatus {
  genuineUnopened('genuine_unopened', 'Genuine Bottle (Unopened)'),
  genuineOpened('genuine_opened', 'Genuine Bottle (Opened)'),
  empty('empty', 'Empty Bottle');

  const BottleStatus(this.value, this.displayName);

  final String value;
  final String displayName;

  static BottleStatus fromString(String value) {
    return BottleStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => BottleStatus.genuineUnopened,
    );
  }
}

class TastingNotesModel extends Equatable {
  const TastingNotesModel({
    required this.author,
    required this.nose,
    required this.palate,
    required this.finish,
    this.userNotes,
  });

  factory TastingNotesModel.fromJson(Map<String, dynamic> json) {
    return TastingNotesModel(
      author: json['author'] as String,
      nose: (json['nose'] as List<dynamic>).cast<String>(),
      palate: (json['palate'] as List<dynamic>).cast<String>(),
      finish: (json['finish'] as List<dynamic>).cast<String>(),
      userNotes: json['user_notes'] != null
          ? UserTastingNotes.fromJson(
              json['user_notes'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  final String author;
  final List<String> nose;
  final List<String> palate;
  final List<String> finish;
  final UserTastingNotes? userNotes;

  Map<String, dynamic> toJson() => {
        'author': author,
        'nose': nose,
        'palate': palate,
        'finish': finish,
        'user_notes': userNotes?.toJson(),
      };

  @override
  List<Object?> get props => [author, nose, palate, finish, userNotes];
}

class UserTastingNotes extends Equatable {
  const UserTastingNotes({
    required this.nose,
    required this.palate,
    required this.finish,
  });

  factory UserTastingNotes.fromJson(Map<String, dynamic> json) {
    return UserTastingNotes(
      nose: (json['nose'] as List<dynamic>).cast<String>(),
      palate: (json['palate'] as List<dynamic>).cast<String>(),
      finish: (json['finish'] as List<dynamic>).cast<String>(),
    );
  }

  final List<String> nose;
  final List<String> palate;
  final List<String> finish;

  Map<String, dynamic> toJson() => {
        'nose': nose,
        'palate': palate,
        'finish': finish,
      };

  @override
  List<Object?> get props => [nose, palate, finish];
}

class HistoryItemModel extends Equatable {
  const HistoryItemModel({
    required this.label,
    required this.title,
    required this.descriptions,
    this.attachments,
  });

  factory HistoryItemModel.fromJson(Map<String, dynamic> json) {
    return HistoryItemModel(
      label: json['label'] as String,
      title: json['title'] as String,
      descriptions: (json['descriptions'] as List<dynamic>).cast<String>(),
      attachments: json['attachments'] != null
          ? (json['attachments'] as List<dynamic>).cast<String>()
          : null,
    );
  }

  final String label;
  final String title;
  final List<String> descriptions;
  final List<String>? attachments;

  Map<String, dynamic> toJson() => {
        'label': label,
        'title': title,
        'descriptions': descriptions,
        'attachments': attachments,
      };

  @override
  List<Object?> get props => [label, title, descriptions, attachments];
}
