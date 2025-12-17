import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pixelfield_test/core/api_service/api_service.dart';
import 'package:pixelfield_test/core/app_preferences/app_preferences.dart';
import 'package:pixelfield_test/core/enums/sign_up_type_enum.dart';
import 'package:pixelfield_test/core/offline/offline_data_source.dart';
import 'package:pixelfield_test/core/permissions/permission_manager.dart';
import 'package:pixelfield_test/core/services/connectivity_service.dart';
import 'package:pixelfield_test/features/home/data/repository/collection_repository_impl.dart';
import 'package:pixelfield_test/features/home/domain/repository/collection_repository.dart';
import 'package:pixelfield_test/features/product/data/repository/product_repository_impl.dart';
import 'package:pixelfield_test/features/product/domain/repository/product_repository.dart';

abstract class AppModule {
  static late final GetIt _container;

  static Future<void> setup(GetIt container) async {
    _container = container;
    await _setupHive();
    await _setupAppPreferences();
    await _setupAPIService();
    await _setupPermissionManager();
    await _setupConnectivityService();
    _setupOfflineDataSource();
    await _setupRepositories();
  }

  static Future<void> _setupHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SignUpTypeAdapter());
  }

  static Future<void> _setupPermissionManager() async {
    final permissionManager = PermissionManager();
    _container.registerSingleton<PermissionManager>(permissionManager);
  }

  static Future<void> _setupAPIService() async {
    final apiService = ApiService();
    _container.registerSingleton<ApiService>(apiService);
  }

  static Future<void> _setupAppPreferences() async {
    final appPreferences = AppPreferences();
    await appPreferences.init('app-storage');
    _container.registerSingleton<AppPreferences>(appPreferences);
  }

  static Future<void> _setupConnectivityService() async {
    final connectivityService = ConnectivityService();
    _container.registerSingleton<ConnectivityService>(connectivityService);
  }

  static void _setupOfflineDataSource() {
    _container.registerLazySingleton<OfflineDataSource>(
      OfflineDataSource.new,
    );
  }

  static Future<void> _setupRepositories() async {
    _container.registerLazySingleton<CollectionRepository>(
      CollectionRepositoryImpl.new,
    );
    _container.registerLazySingleton<ProductRepository>(
      ProductRepositoryImpl.new,
    );
  }
}
