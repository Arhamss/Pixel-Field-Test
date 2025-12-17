import 'package:pixelfield_test/core/app_preferences/app_preferences.dart';
import 'package:pixelfield_test/core/di/injector.dart';
import 'package:pixelfield_test/core/offline/collection_filter.dart';
import 'package:pixelfield_test/core/offline/product_filter.dart';
import 'package:pixelfield_test/features/home/domain/models/collection_model.dart';
import 'package:pixelfield_test/features/product/domain/models/product_model.dart';

/// Offline data source for querying cached data with filtering support
class OfflineDataSource {
  OfflineDataSource({
    AppPreferences? appPreferences,
  }) : _appPreferences = appPreferences ?? Injector.resolve<AppPreferences>();

  final AppPreferences _appPreferences;

  // ============ Products ============

  /// Get all cached products
  List<ProductModel>? getAllProducts() {
    final cachedData = _appPreferences.getCachedProducts();
    if (cachedData == null) return null;

    return cachedData.map(ProductModel.fromJson).toList();
  }

  /// Query products with optional filter
  List<ProductModel>? queryProducts({ProductFilter? filter}) {
    final products = getAllProducts();
    if (products == null) return null;

    if (filter == null || !filter.hasFilters) {
      return _sortProducts(products, filter?.sortBy, filter?.sortAscending);
    }

    final filtered = products.where((product) {
      // Search query - searches across multiple fields
      if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
        final query = filter.searchQuery!.toLowerCase();
        final matchesSearch = product.name.toLowerCase().contains(query) ||
            product.distillery.toLowerCase().contains(query) ||
            product.region.toLowerCase().contains(query) ||
            product.type.toLowerCase().contains(query) ||
            product.caskNumber.toLowerCase().contains(query);
        if (!matchesSearch) return false;
      }

      // Distillery filter
      if (filter.distillery != null &&
          product.distillery.toLowerCase() !=
              filter.distillery!.toLowerCase()) {
        return false;
      }

      // Region filter
      if (filter.region != null &&
          product.region.toLowerCase() != filter.region!.toLowerCase()) {
        return false;
      }

      // Country filter
      if (filter.country != null &&
          product.country.toLowerCase() != filter.country!.toLowerCase()) {
        return false;
      }

      // Type filter
      if (filter.type != null &&
          product.type.toLowerCase() != filter.type!.toLowerCase()) {
        return false;
      }

      // Status filter
      if (filter.status != null && product.status != filter.status) {
        return false;
      }

      // Collection name filter
      if (filter.collectionName != null &&
          product.collectionName.toLowerCase() !=
              filter.collectionName!.toLowerCase()) {
        return false;
      }

      // Age range filter
      if (filter.minAge != null && product.age < filter.minAge!) {
        return false;
      }
      if (filter.maxAge != null && product.age > filter.maxAge!) {
        return false;
      }

      return true;
    }).toList();

    return _sortProducts(filtered, filter.sortBy, filter.sortAscending);
  }

  /// Get a single product by ID
  ProductModel? getProductById(String id) {
    // First check individual product cache
    if (_appPreferences.hasProductCache(id)) {
      final cachedData = _appPreferences.getCachedProduct(id);
      if (cachedData != null) {
        return ProductModel.fromJson(cachedData);
      }
    }

    // Fall back to products list cache
    final products = getAllProducts();
    return products?.where((p) => p.id == id).firstOrNull;
  }

  /// Get unique values for filter options
  Set<String> getUniqueDistilleries() {
    final products = getAllProducts();
    if (products == null) return {};
    return products.map((p) => p.distillery).toSet();
  }

  Set<String> getUniqueRegions() {
    final products = getAllProducts();
    if (products == null) return {};
    return products.map((p) => p.region).toSet();
  }

  Set<String> getUniqueCountries() {
    final products = getAllProducts();
    if (products == null) return {};
    return products.map((p) => p.country).toSet();
  }

  Set<String> getUniqueTypes() {
    final products = getAllProducts();
    if (products == null) return {};
    return products.map((p) => p.type).toSet();
  }

  Set<String> getUniqueCollectionNames() {
    final products = getAllProducts();
    if (products == null) return {};
    return products.map((p) => p.collectionName).toSet();
  }

  (int, int)? getAgeRange() {
    final products = getAllProducts();
    if (products == null || products.isEmpty) return null;

    final ages = products.map((p) => p.age).toList()..sort();
    return (ages.first, ages.last);
  }

  List<ProductModel> _sortProducts(
    List<ProductModel> products,
    ProductSortBy? sortBy,
    bool? ascending,
  ) {
    final sorted = List<ProductModel>.from(products);
    final asc = ascending ?? true;

    sorted.sort((a, b) {
      int comparison;
      switch (sortBy) {
        case ProductSortBy.age:
          comparison = a.age.compareTo(b.age);
        case ProductSortBy.distillery:
          comparison = a.distillery.compareTo(b.distillery);
        case ProductSortBy.region:
          comparison = a.region.compareTo(b.region);
        case ProductSortBy.status:
          comparison = a.status.index.compareTo(b.status.index);
        case ProductSortBy.name:
        case null:
          comparison = a.name.compareTo(b.name);
      }
      return asc ? comparison : -comparison;
    });

    return sorted;
  }

  // ============ Collections ============

  /// Get all cached collections
  List<CollectionModel>? getAllCollections() {
    final cachedData = _appPreferences.getCachedCollections();
    if (cachedData == null) return null;

    return cachedData.map(CollectionModel.fromJson).toList();
  }

  /// Query collections with optional filter
  List<CollectionModel>? queryCollections({CollectionFilter? filter}) {
    final collections = getAllCollections();
    if (collections == null) return null;

    if (filter == null || !filter.hasFilters) {
      return _sortCollections(
        collections,
        filter?.sortBy,
        filter?.sortAscending,
      );
    }

    final filtered = collections.where((collection) {
      // Search query
      if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
        final query = filter.searchQuery!.toLowerCase();
        final matchesSearch = collection.name.toLowerCase().contains(query);
        if (!matchesSearch) return false;
      }

      // Collection ID filter
      if (filter.collectionId != null && collection.id != filter.collectionId) {
        return false;
      }

      return true;
    }).toList();

    return _sortCollections(filtered, filter.sortBy, filter.sortAscending);
  }

  /// Get a single collection by ID
  CollectionModel? getCollectionById(String id) {
    final collections = getAllCollections();
    return collections?.where((c) => c.id == id).firstOrNull;
  }

  /// Query products within a specific collection
  List<CollectionProductModel>? queryCollectionProducts({
    required String collectionId,
    String? searchQuery,
  }) {
    final collection = getCollectionById(collectionId);
    if (collection == null) return null;

    if (searchQuery == null || searchQuery.isEmpty) {
      return collection.products;
    }

    final query = searchQuery.toLowerCase();
    return collection.products.where((product) {
      return product.name.toLowerCase().contains(query);
    }).toList();
  }

  List<CollectionModel> _sortCollections(
    List<CollectionModel> collections,
    CollectionSortBy? sortBy,
    bool? ascending,
  ) {
    final sorted = List<CollectionModel>.from(collections);
    final asc = ascending ?? true;

    sorted.sort((a, b) {
      int comparison;
      switch (sortBy) {
        case CollectionSortBy.productCount:
          comparison = a.productCount.compareTo(b.productCount);
        case CollectionSortBy.name:
        case null:
          comparison = a.name.compareTo(b.name);
      }
      return asc ? comparison : -comparison;
    });

    return sorted;
  }

  // ============ Cache Status ============

  bool get hasProductsCache => _appPreferences.hasProductsCache();

  bool get hasCollectionsCache => _appPreferences.hasCollectionsCache();

  bool get hasAnyCache => hasProductsCache || hasCollectionsCache;
}
