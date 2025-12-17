import 'package:pixelfield_test/core/api_service/api_service.dart';
import 'package:pixelfield_test/core/di/injector.dart';
import 'package:pixelfield_test/features/onboarding/domain/repository/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl({ApiService? apiService})
    : _apiService = apiService ?? Injector.resolve<ApiService>();

  final ApiService _apiService;
}
