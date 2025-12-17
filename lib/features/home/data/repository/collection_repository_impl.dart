import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pixelfield_test/core/app_preferences/app_preferences.dart';
import 'package:pixelfield_test/core/di/injector.dart';
import 'package:pixelfield_test/core/offline/collection_filter.dart';
import 'package:pixelfield_test/core/offline/offline_data_source.dart';
import 'package:pixelfield_test/core/services/connectivity_service.dart';
import 'package:pixelfield_test/features/home/domain/models/collection_model.dart';
import 'package:pixelfield_test/features/home/domain/repository/collection_repository.dart';
import 'package:pixelfield_test/utils/helpers/repository_response.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  CollectionRepositoryImpl({
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

  static const String _mockDataPath = 'assets/mock/collection_data.json';

  @override
  Future<RepositoryResponse<List<CollectionModel>>> getCollections({
    CollectionFilter? filter,
  }) async {
    try {
      final hasConnection =
          await _connectivityService.hasInternetConnection();

      // If no connection, use offline data source with filtering
      if (!hasConnection) {
        return _getOfflineCollections(filter);
      }

      // Simulate network delay
      await Future<void>.delayed(const Duration(milliseconds: 800));

      final jsonString = await rootBundle.loadString(_mockDataPath);
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;

      final collectionsJson = jsonData['collections'] as List<dynamic>;

      // Cache the fetched data
      _appPreferences.cacheCollections(
        collectionsJson.cast<Map<String, dynamic>>(),
      );

      // Use offline data source to apply filters on fresh data
      final collections = _offlineDataSource.queryCollections(filter: filter);

      return RepositoryResponse(
        isSuccess: true,
        data: collections ?? [],
      );
    } catch (e) {
      // On error, try to return cached data with filtering
      final cachedResponse = _getOfflineCollections(filter);
      if (cachedResponse.isSuccess) {
        return cachedResponse;
      }

      return RepositoryResponse(
        isSuccess: false,
        message: 'Failed to load collections: $e',
      );
    }
  }

  RepositoryResponse<List<CollectionModel>> _getOfflineCollections(
    CollectionFilter? filter,
  ) {
    final collections = _offlineDataSource.queryCollections(filter: filter);
    if (collections != null) {
      return RepositoryResponse(
        isSuccess: true,
        data: collections,
      );
    }

    return RepositoryResponse(
      isSuccess: false,
      message: 'No internet connection and no cached data available',
    );
  }

  @override
  Future<RepositoryResponse<CollectionModel>> getCollectionById(
    String id,
  ) async {
    try {
      final hasConnection =
          await _connectivityService.hasInternetConnection();

      if (!hasConnection) {
        return _getOfflineCollectionById(id);
      }

      // Simulate network delay
      await Future<void>.delayed(const Duration(milliseconds: 500));

      final jsonString = await rootBundle.loadString(_mockDataPath);
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;

      final collectionsJson = jsonData['collections'] as List<dynamic>;

      // Cache all collections while we have them
      _appPreferences.cacheCollections(
        collectionsJson.cast<Map<String, dynamic>>(),
      );

      final collection = _offlineDataSource.getCollectionById(id);
      if (collection == null) {
        return RepositoryResponse(
          isSuccess: false,
          message: 'Collection not found',
        );
      }

      return RepositoryResponse(
        isSuccess: true,
        data: collection,
      );
    } catch (e) {
      // On error, try to return cached data
      final cachedResponse = _getOfflineCollectionById(id);
      if (cachedResponse.isSuccess) {
        return cachedResponse;
      }

      return RepositoryResponse(
        isSuccess: false,
        message: 'Failed to load collection: $e',
      );
    }
  }

  RepositoryResponse<CollectionModel> _getOfflineCollectionById(String id) {
    final collection = _offlineDataSource.getCollectionById(id);
    if (collection != null) {
      return RepositoryResponse(
        isSuccess: true,
        data: collection,
      );
    }

    return RepositoryResponse(
      isSuccess: false,
      message: 'No internet connection and no cached data available',
    );
  }

  @override
  Future<RepositoryResponse<List<CollectionProductModel>>>
      getCollectionProducts({
    required String collectionId,
    String? searchQuery,
  }) async {
    try {
      final hasConnection =
          await _connectivityService.hasInternetConnection();

      if (!hasConnection) {
        return _getOfflineCollectionProducts(
          collectionId: collectionId,
          searchQuery: searchQuery,
        );
      }

      // Ensure we have fresh data
      await getCollectionById(collectionId);

      final products = _offlineDataSource.queryCollectionProducts(
        collectionId: collectionId,
        searchQuery: searchQuery,
      );

      if (products == null) {
        return RepositoryResponse(
          isSuccess: false,
          message: 'Collection not found',
        );
      }

      return RepositoryResponse(
        isSuccess: true,
        data: products,
      );
    } catch (e) {
      final cachedResponse = _getOfflineCollectionProducts(
        collectionId: collectionId,
        searchQuery: searchQuery,
      );
      if (cachedResponse.isSuccess) {
        return cachedResponse;
      }

      return RepositoryResponse(
        isSuccess: false,
        message: 'Failed to load collection products: $e',
      );
    }
  }

  RepositoryResponse<List<CollectionProductModel>>
      _getOfflineCollectionProducts({
    required String collectionId,
    String? searchQuery,
  }) {
    final products = _offlineDataSource.queryCollectionProducts(
      collectionId: collectionId,
      searchQuery: searchQuery,
    );

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
}
