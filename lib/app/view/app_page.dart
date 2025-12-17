import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:pixelfield_test/app/view/app_view.dart';
import 'package:pixelfield_test/core/locale/cubit/locale_cubit.dart';
import 'package:pixelfield_test/exports.dart';
import 'package:pixelfield_test/features/home/presentation/cubit/collection_cubit.dart';
import 'package:pixelfield_test/features/onboarding/data/repository/onboarding_repository_impl.dart';
import 'package:pixelfield_test/features/onboarding/presentation/cubit/cubit.dart';
import 'package:pixelfield_test/features/product/presentation/cubit/product_detail_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LocaleCubit(context: context),
          ),
          BlocProvider(
            create: (context) =>
                OnboardingCubit(repository: OnboardingRepositoryImpl()),
          ),
          BlocProvider(
            create: (context) => CollectionCubit(),
          ),
          BlocProvider(
            create: (context) => ProductDetailCubit(),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}
