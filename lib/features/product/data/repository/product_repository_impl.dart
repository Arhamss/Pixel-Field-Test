import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pixelfield_test/core/app_preferences/app_preferences.dart';
import 'package:pixelfield_test/core/di/injector.dart';
import 'package:pixelfield_test/core/offline/offline_data_source.dart';
import 'package:pixelfield_test/core/offline/product_filter.dart';
import 'package:pixelfield_test/core/services/connectivity_service.dart';
import 'package:pixelfield_test/features/product/domain/models/product_model.dart';
import 'package:pixelfield_test/features/product/domain/repository/product_repository.dart';
import 'package:pixelfield_test/utils/helpers/repository_response.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    ConnectivityService? connectivityService,
    AppPreferences? appPreferences,
    OfflineDataSource? offlineDataSource,
  })  : _connectivityService =
            connectivityService ?? Injector.resolve<ConnectivityService>(),
        _appPreferences = appPreferences ?? Injector.resolve<AppPreferences>(),
        _offlineDataSource =
            offlineDataSource ?? Injector.resolve<OfflineDataSource>();

  final ConnectivityService _connectivityService;
  final AppPreferences _appPreferences;
  final OfflineDataSource _offlineDataSource;

  static const String _mockDataPath = 'assets/mock/products_data.json';

  @override
  Future<RepositoryResponse<List<ProductModel>>> getProducts({
    ProductFilter? filter,
  }) async {
    try {
      final hasConnection =
          await _connectivityService.hasInternetConnection();

      if (!hasConnection) {
        return _getOfflineProducts(filter);
      }

      // Simulate network delay
      await Future<void>.delayed(const Duration(milliseconds: 800));

      final jsonString = await rootBundle.loadString(_mockDataPath);
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;

      final productsJson = jsonData['products'] as List<dynamic>;

      // Cache the fetched data
      _appPreferences.cacheProducts(
        productsJson.cast<Map<String, dynamic>>(),
      );

      // Use offline data source to apply filters on fresh data
      final products = _offlineDataSource.queryProducts(filter: filter);

      return RepositoryResponse(
        isSuccess: true,
        data: products ?? [],
      );
    } on Exception catch (e) {
      // On error, try to return cached data with filtering
      final cachedResponse = _getOfflineProducts(filter);
      if (cachedResponse.isSuccess) {
        return cachedResponse;
      }

      return RepositoryResponse(
        isSuccess: false,
        message: 'Failed to load products: $e',
      );
    }
  }

  RepositoryResponse<List<ProductModel>> _getOfflineProducts(
    ProductFilter? filter,
  ) {
    final products = _offlineDataSource.queryProducts(filter: filter);
    if (products != null) {
      return RepositoryResponse(
        isSuccess: true,
        data: products,
      );
    }

    return RepositoryResponse(
      isSuccess: false,
      message: 'No internet connection and no cached data available',
    );
  }

  @override
  Future<RepositoryResponse<ProductModel>> getProductById(String id) async {
    try {
      final hasConnection =
          await _connectivityService.hasInternetConnection();

      if (!hasConnection) {
        return _getOfflineProductById(id);
      }

      // Simulate network delay
      await Future<void>.delayed(const Duration(milliseconds: 500));

      final jsonString = await rootBundle.loadString(_mockDataPath);
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;

      final productsJson = jsonData['products'] as List<dynamic>;

      // Cache all products while we have them
      _appPreferences.cacheProducts(
        productsJson.cast<Map<String, dynamic>>(),
      );

      final product = _offlineDataSource.getProductById(id);
      if (product == null) {
        return RepositoryResponse(
          isSuccess: false,
          message: 'Product not found',
        );
      }

      // Also cache the individual product
      _appPreferences.cacheProduct(id, product.toJson());

      return RepositoryResponse(
        isSuccess: true,
        data: product,
      );
    } on Exception catch (e) {
      // On error, try to return cached data
      final cachedResponse = _getOfflineProductById(id);
      if (cachedResponse.isSuccess) {
        return cachedResponse;
      }

      return RepositoryResponse(
        isSuccess: false,
        message: 'Failed to load product: $e',
      );
    }
  }

  RepositoryResponse<ProductModel> _getOfflineProductById(String id) {
    final product = _offlineDataSource.getProductById(id);
    if (product != null) {
      return RepositoryResponse(
        isSuccess: true,
        data: product,
      );
    }

    return RepositoryResponse(
      isSuccess: false,
      message: 'No internet connection and no cached data available',
    );
  }

  @override
  Future<RepositoryResponse<ProductModel>> updateProductStatus(
    String id,
    BottleStatus status,
  ) async {
    try {
      final hasConnection =
          await _connectivityService.hasInternetConnection();

      if (!hasConnection) {
        // Allow updating cache even without connection
        return _updateCachedProductStatus(id, status);
      }

      // Simulate network delay for update
      await Future<void>.delayed(const Duration(milliseconds: 300));

      // In a real app, this would update the backend
      // For mock, we just return the updated product
      final productResponse = await getProductById(id);

      if (!productResponse.isSuccess || productResponse.data == null) {
        return RepositoryResponse(
          isSuccess: false,
          message: 'Product not found',
        );
      }

      final updatedProduct = productResponse.data!.copyWith(status: status);

      // Update the cache with new status
      _appPreferences.updateProductInCache(id, updatedProduct.toJson());

      return RepositoryResponse(
        isSuccess: true,
        data: updatedProduct,
      );
    } on Exception catch (e) {
      return RepositoryResponse(
        isSuccess: false,
        message: 'Failed to update product status: $e',
      );
    }
  }

  RepositoryResponse<ProductModel> _updateCachedProductStatus(
    String id,
    BottleStatus status,
  ) {
    final cachedResponse = _getOfflineProductById(id);
    if (!cachedResponse.isSuccess || cachedResponse.data == null) {
      return RepositoryResponse(
        isSuccess: false,
        message: 'No cached product found to update',
      );
    }

    final updatedProduct = cachedResponse.data!.copyWith(status: status);

    _appPreferences.updateProductInCache(id, updatedProduct.toJson());

    return RepositoryResponse(
      isSuccess: true,
      data: updatedProduct,
    );
  }

  @override
  RepositoryResponse<ProductFilterOptions> getFilterOptions() {
    if (!_offlineDataSource.hasProductsCache) {
      return RepositoryResponse(
        isSuccess: false,
        message: 'No cached data available for filter options',
      );
    }

    return RepositoryResponse(
      isSuccess: true,
      data: ProductFilterOptions(
        distilleries: _offlineDataSource.getUniqueDistilleries(),
        regions: _offlineDataSource.getUniqueRegions(),
        countries: _offlineDataSource.getUniqueCountries(),
        types: _offlineDataSource.getUniqueTypes(),
        collectionNames: _offlineDataSource.getUniqueCollectionNames(),
        ageRange: _offlineDataSource.getAgeRange(),
      ),
    );
  }
}
