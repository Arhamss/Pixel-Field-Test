import 'package:pixelfield_test/exports.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    super.key,
    this.backgroundColor = AppColors.blackPrimary,
    this.textColor = AppColors.white,
    this.disabledTextColor,
    this.disabledBackgroundColor,
    this.borderRadius = 100,
    this.padding = const EdgeInsetsDirectional.symmetric(
      vertical: 12,
      horizontal: 24,
    ),
    this.fontWeight = FontWeight.w600,
    this.splashColor = Colors.black12,
    this.fontSize = 16,
    this.prefixIcon,
    this.suffixIcon,
    this.outsidePadding = const EdgeInsetsDirectional.all(4),
    this.isExpanded = true,
    this.iconSpacing,
    this.disabled = false,
    this.loadingColor = AppColors.white,
    this.borderColor,
    this.borderWidth = 1.0,
    this.textStyle,
    this.hasShadow = false,
  });

  /// Primary button - Black background with white text
  const CustomButton.primary({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.outsidePadding = const EdgeInsetsDirectional.all(4),
    this.isExpanded = true,
    this.iconSpacing,
    this.disabled = false,
    this.hasShadow = false,
  }) : backgroundColor = AppColors.blackPrimary,
       textColor = AppColors.white,
       disabledTextColor = const Color(0x80FFFFFF),
       disabledBackgroundColor = AppColors.textTertiary,
       borderRadius = 100,
       padding = const EdgeInsetsDirectional.symmetric(
         vertical: 16,
         horizontal: 24,
       ),
       fontWeight = FontWeight.w600,
       splashColor = Colors.black12,
       fontSize = 16,
       loadingColor = AppColors.white,
       borderColor = AppColors.blackPrimary,
       borderWidth = 1.0,
       textStyle = null;

  /// Secondary button - White background with black text and border
  const CustomButton.secondary({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.outsidePadding = const EdgeInsetsDirectional.all(4),
    this.isExpanded = true,
    this.iconSpacing,
    this.disabled = false,
    this.hasShadow = false,
    this.padding = const EdgeInsetsDirectional.symmetric(
      vertical: 16,
      horizontal: 24,
    ),
    this.borderWidth = 1.0,
    this.textStyle,
    this.splashColor = Colors.black12,
  }) : backgroundColor = AppColors.white,
       textColor = AppColors.blackPrimary,
       disabledTextColor = AppColors.textTertiary,
       disabledBackgroundColor = AppColors.backgroundTertiary,
       borderRadius = 100,
       fontWeight = FontWeight.w600,
       fontSize = 16,
       loadingColor = AppColors.blackPrimary,
       borderColor = AppColors.blackPrimary;

  /// Tertiary button - Text-only button with no background or border
  const CustomButton.tertiary({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.outsidePadding = const EdgeInsetsDirectional.all(4),
    this.isExpanded = true,
    this.iconSpacing,
    this.disabled = false,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
  }) : backgroundColor = Colors.transparent,
       textColor = AppColors.blackPrimary,
       disabledTextColor = AppColors.textTertiary,
       disabledBackgroundColor = Colors.transparent,
       borderRadius = 100,
       padding = const EdgeInsetsDirectional.symmetric(
         vertical: 12,
         horizontal: 16,
       ),
       splashColor = Colors.black12,
       loadingColor = AppColors.blackPrimary,
       borderColor = null,
       borderWidth = 0.0,
       textStyle = null,
       hasShadow = false;

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsDirectional padding;
  final FontWeight fontWeight;
  final Color splashColor;
  final double fontSize;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsDirectional? outsidePadding;
  final bool isExpanded;
  final double? iconSpacing;
  final bool disabled;
  final Color? disabledTextColor;
  final Color? disabledBackgroundColor;
  final Color loadingColor;
  final Color? borderColor;
  final double borderWidth;
  final TextStyle? textStyle;
  final bool hasShadow;

  @override
  Widget build(BuildContext context) {
    final effectiveDisabledBackgroundColor =
        disabledBackgroundColor ?? AppColors.blackPrimary;
    final effectiveDisabledTextColor =
        disabledTextColor ?? AppColors.white.withValues(alpha: 0.5);

    final buttonContent = TextButton(
      onPressed: (isLoading || disabled) ? null : onPressed,
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        backgroundColor: disabled
            ? effectiveDisabledBackgroundColor
            : backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: borderColor != null
              ? BorderSide(
                  color: disabled
                      ? borderColor!.withValues(alpha: 0.5)
                      : borderColor!,
                  width: borderWidth,
                )
              : BorderSide.none,
        ),
        splashFactory: InkRipple.splashFactory,
        overlayColor: splashColor,
      ),
      child: Padding(
        padding: padding,
        child: isLoading
            ? SizedBox(
                height: 23,
                width: 23,
                child: LoadingWidget(color: textColor),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    SizedBox(width: iconSpacing ?? 8),
                  ],
                  Flexible(
                    child: Text(
                      text,
                      style:
                          textStyle ??
                          context.h2.copyWith(
                            color: disabled
                                ? effectiveDisabledTextColor
                                : textColor,
                            fontWeight: fontWeight,
                            fontSize: fontSize,
                          ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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

    final Widget buttonWidget = Padding(
      padding: outsidePadding ?? EdgeInsets.zero,
      child: isExpanded
          ? Row(children: [Expanded(child: buttonContent)])
          : buttonContent,
    );

    if (hasShadow) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 15,
              color: AppColors.blackPrimary.withValues(alpha: 0.05),
            ),
          ],
        ),
        child: buttonWidget,
      );
    }

    return buttonWidget;
  }
}
