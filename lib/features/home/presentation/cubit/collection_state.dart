import 'package:equatable/equatable.dart';
import 'package:pixelfield_test/features/home/domain/models/collection_model.dart';
import 'package:pixelfield_test/utils/helpers/data_state.dart';

class CollectionState extends Equatable {
  const CollectionState({
    this.collections = const DataState(),
  });

  final DataState<List<CollectionModel>> collections;

  List<CollectionProductModel> get allProducts {
    if (collections.data == null) return [];
    return collections.data!.expand((c) => c.products).toList();
  }

  int get totalProducts => allProducts.length;

  CollectionState copyWith({
    DataState<List<CollectionModel>>? collections,
  }) {
    return CollectionState(
      collections: collections ?? this.collections,
    );
  }

  @override
  List<Object?> get props => [collections];
}
