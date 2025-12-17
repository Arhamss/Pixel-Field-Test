import 'package:pixelfield_test/exports.dart';

class RMBTile extends StatelessWidget {
  const RMBTile({
    required this.label,
    super.key,
    this.showIcon = false,
    this.onTap,
    this.iconPath,
  });

  final String label;
  final bool showIcon;
  final VoidCallback? onTap;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.blackPrimary,
          borderRadius: BorderRadius.circular(44),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.blackPrimary,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
            if (showIcon)
              if (iconPath!.contains('svg'))
                SvgPicture.asset(iconPath!)
              else
                Image.asset(iconPath!),
          ],
        ),
      ),
    );
  }
}
