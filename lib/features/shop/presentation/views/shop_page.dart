import 'package:pixelfield_test/exports.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyscaleBlack3,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetPaths.shopIcon,
                width: 64,
                height: 64,
                colorFilter: const ColorFilter.mode(
                  AppColors.greyscaleGrey2,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Shop',
                style: context.h2.copyWith(color: AppColors.greyscaleGrey1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
