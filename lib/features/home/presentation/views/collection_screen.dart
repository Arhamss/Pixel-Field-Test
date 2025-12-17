import 'package:pixelfield_test/exports.dart';
import 'package:pixelfield_test/features/home/domain/models/collection_model.dart';
import 'package:pixelfield_test/features/home/presentation/cubit/collection_cubit.dart';
import 'package:pixelfield_test/features/home/presentation/cubit/collection_state.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<CollectionCubit>().loadCollections();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyscaleBlack2,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My collection',
                    style: context.h1,
                  ),
                  _NotificationButton(
                    hasNotification: true,
                    onTap: () {
                      // TODO(notifications): Navigate to notifications
                    },
                  ),
                ],
              ),
            ),
            // Collection grid
            Expanded(
              child: BlocBuilder<CollectionCubit, CollectionState>(
                builder: (context, state) {
                  if (state.collections.isLoading) {
                    return const _LoadingGrid();
                  }

                  if (state.collections.isFailure) {
                    return _ErrorView(
                      message:
                          state.collections.errorMessage ??
                          'Failed to load collections',
                      onRetry: () =>
                          context.read<CollectionCubit>().loadCollections(),
                    );
                  }

                  if (state.collections.isLoaded) {
                    final products = state.allProducts;

                    if (products.isEmpty) {
                      return const _EmptyView();
                    }

                    return RefreshIndicator(
                      onRefresh: () =>
                          context.read<CollectionCubit>().refreshCollections(),
                      color: AppColors.primary,
                      child: GridView.builder(
                        padding: const EdgeInsetsDirectional.only(
                          start: 16,
                          end: 16,
                          bottom: 16,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.5367412141,
                            ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return _CollectionItem(
                            product: product,
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingGrid extends StatelessWidget {
  const _LoadingGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.5367412141,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: AppColors.greyscaleBlack1,
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Center(
          child: LoadingWidget(),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.greyscaleGrey2,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: context.bodyLarge.copyWith(
                color: AppColors.greyscaleGrey2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Retry',
              onPressed: onRetry,
              backgroundColor: AppColors.primary,
              textColor: AppColors.greyscaleBlack3,
              borderRadius: 8,
              isExpanded: false,
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.inventory_2_outlined,
              size: 48,
              color: AppColors.greyscaleGrey2,
            ),
            const SizedBox(height: 16),
            Text(
              'Your collection is empty',
              style: context.h3.copyWith(
                color: AppColors.greyscaleGrey1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Scan a bottle to add it to your collection',
              style: context.bodyLarge.copyWith(
                color: AppColors.greyscaleGrey2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton({
    required this.hasNotification,
    required this.onTap,
  });

  final bool hasNotification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          SvgPicture.asset(
            AssetPaths.bellIcon,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.greyscaleGrey1,
              BlendMode.srcIn,
            ),
          ),
          if (hasNotification)
            Positioned(
              right: 2,
              bottom: 3,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.notificationRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CollectionItem extends StatelessWidget {
  const _CollectionItem({
    required this.product,
  });

  final CollectionProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await context.pushNamed(
          AppRouteNames.productDetail,
          extra: product.id,
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.greyscaleBlack1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    AssetPaths.productImg,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: context.h3.copyWith(
                      color: AppColors.greyscaleGrey1,
                      fontSize: 22,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '(${product.quantityDisplay})',
                    style: context.l2.copyWith(
                      color: AppColors.greyscaleGrey4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
