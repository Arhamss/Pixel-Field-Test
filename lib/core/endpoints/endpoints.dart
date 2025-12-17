import 'package:pixelfield_test/config/api_environment.dart';

class Endpoints {
  Endpoints._();

  static String get baseUrl => ApiEnvironment.current.baseUrl;

  static String get apiVersion => ApiEnvironment.current.apiVersion;

  /// Authentication
  static const signUp = 'user/auth/register';
  static const guestLogin = 'auth/guest';
  static const refresh = 'auth/refresh';
  static const login = 'user/auth/login';
  static const forgotPassword = 'user/auth/forgot-password';
  static const verifyOtp = 'user/auth/verify-otp';

  /// Home
  static const homeBrands = 'home/brands';
  static const homeProducts = 'home/products';

  /// Brands
  static const brands = 'brands';

  static String brandDetail(String brandId) => 'brands/$brandId';

  /// Products
  static const getProducts = 'user/products';
  static const getCategories = 'user/products/categories';

  /// Services
  static const getServices = 'user/services';

  /// Favorites
  static String setFavorite(String id) => 'user/services/$id/favorite';
}
