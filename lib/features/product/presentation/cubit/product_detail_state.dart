import 'package:equatable/equatable.dart';
import 'package:pixelfield_test/features/product/domain/models/product_model.dart';
import 'package:pixelfield_test/utils/helpers/data_state.dart';

class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.product = const DataState(),
    this.statusUpdate = const DataState(),
  });

  final DataState<ProductModel> product;
  final DataState<ProductModel> statusUpdate;

  ProductDetailState copyWith({
    DataState<ProductModel>? product,
    DataState<ProductModel>? statusUpdate,
  }) {
    return ProductDetailState(
      product: product ?? this.product,
      statusUpdate: statusUpdate ?? this.statusUpdate,
    );
  }

  @override
  List<Object?> get props => [product, statusUpdate];
}
