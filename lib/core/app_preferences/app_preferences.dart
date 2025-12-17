import 'dart:convert';

import 'package:pixelfield_test/core/app_preferences/base_storage.dart';

class AppPreferences extends BaseStorage {
  AppPreferences() {
    init('app-storage');
  }

  final String _authTokenKey = 'auth_token';
  final String _refreshTokenKey = 'refresh_token';
  final String _userIdKey = 'user_id';
  final String _appLocale = 'app_locale';
  final String _userModelKey = 'user_model';

  // Cache keys
  static const String _collectionsKey = 'cached_collections';
  static const String _productsKey = 'cached_products';
  static const String _productPrefix = 'cached_product_';

  /// App Locale
  void setAppLocale(String locale) {
    store<String>(_appLocale, locale);
  }

  String? getAppLocale() {
    return retrieve<String>(_appLocale);
  }

  void clearAppLocale() {
    remove(_appLocale);
  }

  /// Auth Tokens
  void setAuthToken(String token) {
    store<String>(_authTokenKey, token);
  }

  String? getAuthToken() {
    return retrieve<String>(_authTokenKey);
  }

  void removeAuthToken() {
    remove(_authTokenKey);
  }

  /// Refresh Tokens
  void setRefreshToken(String token) {
    store<String>(_refreshTokenKey, token);
  }

  String? getRefreshToken() {
    return retrieve<String>(_refreshTokenKey);
  }

  void removeRefreshToken() {
    remove(_refreshTokenKey);
  }

  /// User ID

  void setUserId(String userId) {
    store<String>(_userIdKey, userId);
  }

  String? getUserId() {
    return retrieve<String>(_userIdKey);
  }

  void removeUserId() {
    remove(_userIdKey);
  }

  /// Clear all auth data
  void clearAuthData() {
    remove(_authTokenKey);
    remove(_refreshTokenKey);
    remove(_userIdKey);
  }

  /// Clear all data
  void clearAll() {
    removeAll();
  }

  // ============ Cache Methods ============

  /// Collections Cache
  void cacheCollections(List<Map<String, dynamic>> collections) {
    store<String>(_collectionsKey, jsonEncode(collections));
  }

  List<Map<String, dynamic>>? getCachedCollections() {
    final data = retrieve<String>(_collectionsKey);
    if (data == null) return null;

    final decoded = jsonDecode(data) as List<dynamic>;
    return decoded.cast<Map<String, dynamic>>();
  }

  bool hasCollectionsCache() => hasData(_collectionsKey);

  void clearCollectionsCache() {
    remove(_collectionsKey);
  }

  /// Products Cache
  void cacheProducts(List<Map<String, dynamic>> products) {
    store<String>(_productsKey, jsonEncode(products));
  }

  List<Map<String, dynamic>>? getCachedProducts() {
    final data = retrieve<String>(_productsKey);
    if (data == null) return null;

    final decoded = jsonDecode(data) as List<dynamic>;
    return decoded.cast<Map<String, dynamic>>();
  }

  bool hasProductsCache() => hasData(_productsKey);

  void clearProductsCache() {
    remove(_productsKey);
  }

  /// Single Product Cache
  void cacheProduct(String productId, Map<String, dynamic> product) {
    store<String>('$_productPrefix$productId', jsonEncode(product));
  }

  Map<String, dynamic>? getCachedProduct(String productId) {
    final data = retrieve<String>('$_productPrefix$productId');
    if (data == null) return null;

    return jsonDecode(data) as Map<String, dynamic>;
  }

  bool hasProductCache(String productId) {
    return hasData('$_productPrefix$productId');
  }

  void clearProductCache(String productId) {
    remove('$_productPrefix$productId');
  }

  /// Update single product in products cache
  void updateProductInCache(
    String productId,
    Map<String, dynamic> updatedProduct,
  ) {
    // Update individual product cache
    cacheProduct(productId, updatedProduct);

    // Also update in the products list cache if it exists
    final products = getCachedProducts();
    if (products != null) {
      final index = products.indexWhere((p) => p['id'] == productId);
      if (index != -1) {
        products[index] = updatedProduct;
        cacheProducts(products);
      }
    }
  }

  /// Clear all cache data
  void clearAllCache() {
    clearCollectionsCache();
    clearProductsCache();
  }
}
