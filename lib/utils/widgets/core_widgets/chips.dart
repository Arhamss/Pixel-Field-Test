import 'package:pixelfield_test/exports.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    required this.text,
    required this.onTap,
    this.backgroundColor = AppColors.blackPrimary,
    this.fontColor = AppColors.blackPrimary,
    this.isSelected = false,
    this.fontStyle,
    this.padding,
    super.key,
  });

  final bool isSelected;
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color fontColor;
  final TextStyle? fontStyle;
  final EdgeInsetsDirectional? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? backgroundColor : backgroundColor,
          borderRadius: BorderRadius.circular(100),
        ),
        padding:
            padding ??
            const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 4),
        child: Text(
          text,
          style:
              fontStyle ?? context.t3.copyWith(fontSize: 12, color: fontColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
