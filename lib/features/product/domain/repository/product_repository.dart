import 'package:pixelfield_test/core/offline/product_filter.dart';
import 'package:pixelfield_test/features/product/domain/models/product_model.dart';
import 'package:pixelfield_test/utils/helpers/repository_response.dart';

abstract class ProductRepository {
  Future<RepositoryResponse<List<ProductModel>>> getProducts({
    ProductFilter? filter,
  });

  Future<RepositoryResponse<ProductModel>> getProductById(String id);

  Future<RepositoryResponse<ProductModel>> updateProductStatus(
    String id,
    BottleStatus status,
  );

  /// Get available filter options from cached data
  RepositoryResponse<ProductFilterOptions> getFilterOptions();
}

/// Available filter options derived from cached products
class ProductFilterOptions {
  const ProductFilterOptions({
    required this.distilleries,
    required this.regions,
    required this.countries,
    required this.types,
    required this.collectionNames,
    required this.ageRange,
  });

  final Set<String> distilleries;
  final Set<String> regions;
  final Set<String> countries;
  final Set<String> types;
  final Set<String> collectionNames;
  final (int, int)? ageRange;

  bool get hasOptions =>
      distilleries.isNotEmpty ||
      regions.isNotEmpty ||
      countries.isNotEmpty ||
      types.isNotEmpty ||
      collectionNames.isNotEmpty ||
      ageRange != null;
}
