import 'package:google_fonts/google_fonts.dart';
import 'package:pixelfield_test/exports.dart';

class RMBOutlineButton extends StatelessWidget {
  const RMBOutlineButton({
    required this.text,
    required this.onPressed,
    required this.isLoading,
    super.key,
    this.borderColor = AppColors.blackPrimary,
    this.textColor = AppColors.blackPrimary,
    this.disabledTextColor = AppColors.blackPrimary,
    this.disabledBorderColor,
    this.borderRadius = 100,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
    this.fontWeight = FontWeight.w800,
    this.splashColor = Colors.black12,
    this.fontSize = 18,
    this.prefixIcon,
    this.suffixIcon,
    this.outsidePadding = const EdgeInsets.all(4),
    this.isExpanded = true,
    this.iconSpacing,
    this.disabled = false,
    this.loadingColor,
    this.borderWidth = 1.5,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final FontWeight fontWeight;
  final Color splashColor;
  final double fontSize;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsets? outsidePadding;
  final bool isExpanded;
  final double? iconSpacing;
  final bool disabled;
  final Color disabledTextColor;
  final Color? disabledBorderColor;
  final Color? loadingColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = disabled
        ? (disabledBorderColor ?? borderColor.withValues(alpha: 0.5))
        : borderColor;

    final button = TextButton(
      onPressed: (isLoading || disabled) ? null : onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsetsDirectional.zero,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: effectiveBorderColor, width: borderWidth),
        ),
        splashFactory: InkRipple.splashFactory,
        overlayColor: splashColor,
      ),
      child: Padding(
        padding: padding,
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: LoadingWidget(color: loadingColor ?? textColor),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    SizedBox(width: iconSpacing ?? 8),
                  ],
                  Text(
                    text,
                    style: GoogleFonts.urbanist(
                      color: disabled ? disabledTextColor : textColor,
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    SizedBox(width: iconSpacing ?? 8),
                    suffixIcon!,
                  ],
                ],
              ),
      ),
    );

    return Padding(
      padding: outsidePadding ?? EdgeInsetsDirectional.zero,
      child: isExpanded ? Row(children: [Expanded(child: button)]) : button,
    );
  }
}
