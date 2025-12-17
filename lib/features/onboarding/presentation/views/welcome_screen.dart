import 'package:pixelfield_test/exports.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                decoration: BoxDecoration(
                  color: AppColors.greyscaleBlack1,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Welcome text
                    Text(
                      'Welcome!',
                      style: context.h1,
                    ),
                    const SizedBox(height: 8),
                    // Subtitle text
                    Text(
                      'Text text text',
                      style: context.b1.copyWith(
                        color: AppColors.greyscaleGrey1,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Scan bottle button
                    CustomButton(
                      padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 20,
                      ),
                      text: 'Scan bottle',
                      onPressed: () {
                        context.goNamed(AppRouteNames.scan);
                      },
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.greyscaleBlack3,
                      borderRadius: 12,
                      outsidePadding: EdgeInsetsDirectional.zero,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account? ',
                          style: context.b1.copyWith(
                            color: AppColors.greyscaleGrey2,
                          ),
                        ),
                        const SizedBox(width: 24),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(AppRouteNames.login);
                          },
                          child: Text(
                            'Sign in first',
                            style: context.t3.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
