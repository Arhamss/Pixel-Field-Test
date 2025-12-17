import 'package:equatable/equatable.dart';

class CollectionModel extends Equatable {
  const CollectionModel({
    required this.id,
    required this.name,
    required this.products,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => CollectionProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final String id;
  final String name;
  final List<CollectionProductModel> products;

  int get productCount => products.length;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'products': products.map((e) => e.toJson()).toList(),
      };

  CollectionModel copyWith({
    String? id,
    String? name,
    List<CollectionProductModel>? products,
  }) {
    return CollectionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [id, name, products];
}

class CollectionProductModel extends Equatable {
  const CollectionProductModel({
    required this.id,
    required this.name,
    required this.availableQuantity,
    required this.totalQuantity,
    required this.imageUrl,
  });

  factory CollectionProductModel.fromJson(Map<String, dynamic> json) {
    return CollectionProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      availableQuantity: json['available_quantity'] as int,
      totalQuantity: json['total_quantity'] as int,
      imageUrl: json['image_url'] as String,
    );
  }

  final String id;
  final String name;
  final int availableQuantity;
  final int totalQuantity;
  final String imageUrl;

  /// Formatted quantity string (e.g., "135/184")
  String get quantityDisplay => '$availableQuantity/$totalQuantity';

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'available_quantity': availableQuantity,
        'total_quantity': totalQuantity,
        'image_url': imageUrl,
      };

  CollectionProductModel copyWith({
    String? id,
    String? name,
    int? availableQuantity,
    int? totalQuantity,
    String? imageUrl,
  }) {
    return CollectionProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [id, name, availableQuantity, totalQuantity, imageUrl];
}
