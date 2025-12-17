import 'dart:async';

import 'package:pixelfield_test/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(_navigateToWelcome());
  }

  Future<void> _navigateToWelcome() async {
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      context.goNamed(AppRouteNames.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPaths.splashBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(
            AssetPaths.appIcon,
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
