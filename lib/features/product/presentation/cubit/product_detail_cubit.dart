import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelfield_test/core/di/injector.dart';
import 'package:pixelfield_test/features/product/domain/models/product_model.dart';
import 'package:pixelfield_test/features/product/domain/repository/product_repository.dart';
import 'package:pixelfield_test/features/product/presentation/cubit/product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  ProductDetailCubit({
    ProductRepository? repository,
  })  : _repository = repository ?? Injector.resolve<ProductRepository>(),
        super(const ProductDetailState());

  final ProductRepository _repository;

  Future<void> loadProduct(String productId) async {
    emit(state.copyWith(product: state.product.toLoading()));

    final response = await _repository.getProductById(productId);

    if (response.isSuccess && response.data != null) {
      emit(
        state.copyWith(
          product: state.product.toLoaded(data: response.data),
        ),
      );
    } else {
      emit(
        state.copyWith(
          product: state.product.toFailure(
            error: response.message ?? 'Failed to load product',
          ),
        ),
      );
    }
  }

  Future<void> updateStatus(BottleStatus status) async {
    final currentProduct = state.product.data;
    if (currentProduct == null) return;

    emit(state.copyWith(statusUpdate: state.statusUpdate.toLoading()));

    final response = await _repository.updateProductStatus(
      currentProduct.id,
      status,
    );

    if (response.isSuccess && response.data != null) {
      emit(
        state.copyWith(
          product: state.product.toLoaded(data: response.data),
          statusUpdate: state.statusUpdate.toLoaded(data: response.data),
        ),
      );
    } else {
      emit(
        state.copyWith(
          statusUpdate: state.statusUpdate.toFailure(
            error: response.message ?? 'Failed to update status',
          ),
        ),
      );
    }
  }

  Future<void> refreshProduct() async {
    final currentProduct = state.product.data;
    if (currentProduct != null) {
      await loadProduct(currentProduct.id);
    }
  }
}
