import 'package:pixelfield_test/exports.dart';
import 'package:pixelfield_test/features/product/domain/models/product_model.dart';
import 'package:pixelfield_test/features/product/presentation/cubit/product_detail_cubit.dart';
import 'package:pixelfield_test/features/product/presentation/cubit/product_detail_state.dart';
import 'package:pixelfield_test/features/product/presentation/widgets/bottle_status_dropdown.dart';
import 'package:pixelfield_test/features/product/presentation/widgets/detail_row.dart';
import 'package:pixelfield_test/features/product/presentation/widgets/tasting_note_card.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    required this.productId,
    super.key,
  });

  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ProductDetailCubit>().loadProduct(widget.productId);
    });
  }

  void _onTabChanged(int index) {
    setState(() => _selectedTabIndex = index);
  }

  Future<void> _onStatusChanged(int index) async {
    final statuses = [
      BottleStatus.genuineUnopened,
      BottleStatus.genuineOpened,
      BottleStatus.empty,
    ];
    if (index < statuses.length) {
      await context.read<ProductDetailCubit>().updateStatus(statuses[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetPaths.splashBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
            builder: (context, state) {
              if (state.product.isLoading) {
                return const LoadingWidget();
              }

              if (state.product.isFailure) {
                return _ErrorView(
                  message:
                      state.product.errorMessage ?? 'Failed to load product',
                  onRetry: () => context
                      .read<ProductDetailCubit>()
                      .loadProduct(widget.productId),
                );
              }

              if (state.product.isLoaded && state.product.data != null) {
                return _ProductContent(
                  product: state.product.data!,
                  selectedTabIndex: _selectedTabIndex,
                  onTabChanged: _onTabChanged,
                  onStatusChanged: _onStatusChanged,
                );
              }

              return const SizedBox.shrink();
            },
          ),
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

class _ProductContent extends StatelessWidget {
  const _ProductContent({
    required this.product,
    required this.selectedTabIndex,
    required this.onTabChanged,
    required this.onStatusChanged,
  });

  final ProductModel product;
  final int selectedTabIndex;
  final ValueChanged<int> onTabChanged;
  final ValueChanged<int> onStatusChanged;

  int _getStatusIndex() {
    switch (product.status) {
      case BottleStatus.genuineUnopened:
        return 0;
      case BottleStatus.genuineOpened:
        return 1;
      case BottleStatus.empty:
        return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.greyscaleBlack3,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Text(
                    product.collectionName,
                    style: context.b3.copyWith(
                      color: AppColors.greyscaleGrey1,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.greyscaleBlack3,
                    ),
                    child: SvgPicture.asset(
                      AssetPaths.closeIcon,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BottleStatusDropdown(
              items: const [
                BottleStatusItem(
                  title: 'Genuine Bottle (Unopened)',
                  iconPath: AssetPaths.bottleGenuineImg,
                ),
                BottleStatusItem(
                  title: 'Genuine Bottle (Opened)',
                  iconPath: AssetPaths.bottleGenuineImg,
                ),
                BottleStatusItem(
                  title: 'Empty Bottle',
                  iconPath: AssetPaths.bottleGenuineImg,
                ),
              ],
              initialIndex: _getStatusIndex(),
              onChanged: onStatusChanged,
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Image.asset(
              AssetPaths.productImg,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.greyscaleBlack1,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.bottleInfo,
                    style: context.l2.copyWith(
                      color: AppColors.greyscaleGrey2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${product.name} ',
                          style: context.h1.copyWith(
                            color: AppColors.greyscaleGrey1,
                          ),
                        ),
                        TextSpan(
                          text: '${product.age} Year old',
                          style: context.h1.copyWith(
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '#${product.caskNumber}',
                    style: context.h1.copyWith(
                      color: AppColors.greyscaleGrey1,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SlidingTab(
                    labels: const [
                      'Details',
                      'Tasting notes',
                      'History',
                    ],
                    onTapCallbacks: [
                      () => onTabChanged(0),
                      () => onTabChanged(1),
                      () => onTabChanged(2),
                    ],
                    initialIndex: selectedTabIndex,
                    height: 36,
                    backgroundColor: AppColors.greyscaleBlack2,
                    selectedColor: AppColors.primary,
                    selectedTextColor: AppColors.greyscaleBlack3,
                    unselectedTextColor: AppColors.greyscaleGrey3,
                    borderRadius: 6,
                  ),
                  const SizedBox(height: 16),
                  _AnimatedTabContent(
                    selectedIndex: selectedTabIndex,
                    product: product,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: IntrinsicWidth(
              child: CustomButton(
                isExpanded: false,
                text: 'Add to my collection',
                onPressed: () {
                  // TODO(collection): Implement add to collection
                },
                prefixIcon: SvgPicture.asset(AssetPaths.addIcon),
                backgroundColor: AppColors.primary,
                textColor: AppColors.greyscaleBlack3,
                borderRadius: 12,
                padding: const EdgeInsetsDirectional.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                outsidePadding: EdgeInsetsDirectional.zero,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _AnimatedTabContent extends StatelessWidget {
  const _AnimatedTabContent({
    required this.selectedIndex,
    required this.product,
  });

  final int selectedIndex;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    switch (selectedIndex) {
      case 0:
        return _DetailsTab(key: const ValueKey(0), product: product);
      case 1:
        return _TastingNotesTab(key: const ValueKey(1), product: product);
      case 2:
        return _HistoryTab(key: const ValueKey(2), product: product);
      default:
        return _DetailsTab(key: const ValueKey(0), product: product);
    }
  }
}

class _DetailsTab extends StatelessWidget {
  const _DetailsTab({
    required this.product,
    super.key,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetailRow(label: 'Distillery', value: product.distillery),
        DetailRow(label: 'Region', value: product.region),
        DetailRow(label: 'Country', value: product.country),
        DetailRow(label: 'Type', value: product.type),
        DetailRow(label: 'Age statement', value: product.ageStatement),
        DetailRow(label: 'Filled', value: product.filledDate),
        DetailRow(label: 'Bottled', value: product.bottledDate),
        DetailRow(label: 'Cask number', value: product.caskNumber),
        DetailRow(label: 'ABV', value: product.abv),
        DetailRow(label: 'Size', value: product.size),
        DetailRow(label: 'Finish', value: product.finish, isLast: true),
      ],
    );
  }
}

class _TastingNotesTab extends StatefulWidget {
  const _TastingNotesTab({
    required this.product,
    super.key,
  });

  final ProductModel product;

  @override
  State<_TastingNotesTab> createState() => _TastingNotesTabState();
}

class _TastingNotesTabState extends State<_TastingNotesTab> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: widget.product.videoId ?? 'dQw4w9WgXcQ',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tastingNotes = widget.product.tastingNotes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: YoutubePlayer(
            controller: _youtubeController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: AppColors.primary,
            progressColors: const ProgressBarColors(
              playedColor: AppColors.primary,
              handleColor: AppColors.secondary,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Tasting notes',
          style: context.h3.copyWith(
            color: AppColors.greyscaleGrey1,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'by ${tastingNotes?.author ?? 'Unknown'}',
          style: context.bodyLarge.copyWith(
            color: AppColors.greyscaleGrey2,
          ),
        ),
        const SizedBox(height: 16),
        TastingNoteCard(
          title: 'Nose',
          descriptions: tastingNotes?.nose ?? ['No notes available'],
        ),
        const SizedBox(height: 12),
        TastingNoteCard(
          title: 'Palate',
          descriptions: tastingNotes?.palate ?? ['No notes available'],
        ),
        const SizedBox(height: 12),
        TastingNoteCard(
          title: 'Finish',
          descriptions: tastingNotes?.finish ?? ['No notes available'],
        ),
        if (tastingNotes?.userNotes != null) ...[
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your notes',
                style: context.h3.copyWith(
                  color: AppColors.greyscaleGrey1,
                  fontSize: 22,
                ),
              ),
              SvgPicture.asset(AssetPaths.leftArrowIcon),
            ],
          ),
          const SizedBox(height: 16),
          TastingNoteCard(
            title: 'Nose',
            descriptions: tastingNotes!.userNotes!.nose,
          ),
          const SizedBox(height: 12),
          TastingNoteCard(
            title: 'Palate',
            descriptions: tastingNotes.userNotes!.palate,
          ),
          const SizedBox(height: 12),
          TastingNoteCard(
            title: 'Finish',
            descriptions: tastingNotes.userNotes!.finish,
          ),
        ],
      ],
    );
  }
}

class _HistoryTab extends StatelessWidget {
  const _HistoryTab({
    required this.product,
    super.key,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final history = product.history ?? [];

    if (history.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'No history available',
            style: context.bodyLarge.copyWith(
              color: AppColors.greyscaleGrey2,
            ),
          ),
        ),
      );
    }

    return Column(
      children: history.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return _HistoryTimelineItem(
          label: item.label,
          title: item.title,
          descriptions: item.descriptions,
          attachments: item.attachments,
          isLast: index == history.length - 1,
        );
      }).toList(),
    );
  }
}

class _HistoryTimelineItem extends StatelessWidget {
  const _HistoryTimelineItem({
    required this.label,
    required this.title,
    required this.descriptions,
    this.attachments,
    this.isLast = false,
  });

  final String label;
  final String title;
  final List<String> descriptions;
  final List<String>? attachments;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: AppColors.greyscaleGrey1,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: 2,
                          color: AppColors.primary,
                        ),
                      ),
                      Transform.rotate(
                        angle: 0.785398,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 6,
                        color: AppColors.primary,
                      ),
                      Transform.rotate(
                        angle: 0.785398,
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 6,
                        color: AppColors.primary,
                      ),
                      Transform.rotate(
                        angle: 0.785398,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 2,
                          color: AppColors.primary,
                        ),
                      ),
                      Transform.rotate(
                        angle: 0.785398,
                        child: Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      if (isLast) const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.b3.copyWith(
                    color: AppColors.greyscaleGrey1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: context.h3.copyWith(
                    color: AppColors.greyscaleGrey1,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                ...descriptions.map(
                  (desc) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      desc,
                      style: context.bodyLarge.copyWith(
                        color: AppColors.greyscaleGrey1,
                      ),
                    ),
                  ),
                ),
                if (attachments != null && attachments!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.greyscaleBlack2,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AssetPaths.attachmentIcon),
                            const SizedBox(width: 8),
                            Text(
                              'Attachments',
                              style: context.b3.copyWith(
                                color: AppColors.greyscaleGrey1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(
                            attachments!.length.clamp(0, 3),
                            (index) => Expanded(
                              child: Container(
                                height: 80,
                                margin: EdgeInsets.only(
                                  right: index < 2 ? 8 : 0,
                                ),
                                decoration: const BoxDecoration(
                                  color: AppColors.borderPrimary,
                                ),
                                child: Image.asset(
                                  attachments![index],
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const SizedBox(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
