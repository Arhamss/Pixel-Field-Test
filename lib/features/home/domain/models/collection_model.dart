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
    required this.quantity,
    required this.imageUrl,
  });

  factory CollectionProductModel.fromJson(Map<String, dynamic> json) {
    return CollectionProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as String,
      imageUrl: json['image_url'] as String,
    );
  }

  final String id;
  final String name;
  final String quantity;
  final String imageUrl;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'image_url': imageUrl,
      };

  CollectionProductModel copyWith({
    String? id,
    String? name,
    String? quantity,
    String? imageUrl,
  }) {
    return CollectionProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [id, name, quantity, imageUrl];
}
