class AppConstants {
  factory AppConstants() {
    return _singleton;
  }

  AppConstants._internal();

  static final AppConstants _singleton = AppConstants._internal();

  // Pagination limits for different list types
  static const paginationLimit = 16;
}
