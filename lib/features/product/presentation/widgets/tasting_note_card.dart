import 'package:pixelfield_test/exports.dart';

class TastingNoteCard extends StatelessWidget {
  const TastingNoteCard({
    required this.title,
    required this.descriptions,
    super.key,
  });

  final String title;
  final List<String> descriptions;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.greyscaleBlack2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        ],
      ),
    );
  }
}
