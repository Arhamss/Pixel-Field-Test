import 'package:pixelfield_test/exports.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    required this.title,
    this.imagePath,
    this.imageWidget,
    this.subtitle,
    this.onTap,
    this.buttonOneText,
    this.buttonTwoText,
    this.buttonOneOnTap,
    this.buttonTwoOnTap,
    this.buttonOneColor,
    this.buttonTwoColor,
    this.buttonOneTextColor,
    this.buttonTwoTextColor,
    this.isLoading = false,
    this.body,
    super.key,
  });

  final String title;
  final String? imagePath;
  final Widget? imageWidget;
  final String? subtitle;
  final VoidCallback? onTap;
  final String? buttonOneText;
  final String? buttonTwoText;
  final VoidCallback? buttonOneOnTap;
  final VoidCallback? buttonTwoOnTap;
  final Color? buttonOneColor;
  final Color? buttonTwoColor;
  final Color? buttonOneTextColor;
  final Color? buttonTwoTextColor;
  final bool isLoading;
  final Widget? body;

  static void show({
    required BuildContext context,
    required String title,
    String? imagePath,
    Widget? imageWidget,
    String? subtitle,
    String? buttonOneText,
    String? buttonTwoText,
    VoidCallback? buttonOneOnTap,
    VoidCallback? buttonTwoOnTap,
    Color? buttonOneColor,
    Color? buttonTwoColor,
    Color? buttonOneTextColor,
    Color? buttonTwoTextColor,
    double? height,
    VoidCallback? onTap,
    bool isLoading = false,
    Widget? body,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        minWidth: MediaQuery.of(context).size.width,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SizedBox(
          height: height != null
              ? MediaQuery.of(context).size.height * height
              : null,
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: CustomBottomSheet(
              imagePath: imagePath,
              title: title,
              subtitle: subtitle,
              onTap: onTap,
              isLoading: isLoading,
              imageWidget: imageWidget,
              buttonOneText: buttonOneText,
              buttonTwoText: buttonTwoText,
              buttonOneOnTap: buttonOneOnTap,
              buttonTwoOnTap: buttonTwoOnTap,
              buttonOneColor: buttonOneColor,
              buttonTwoColor: buttonTwoColor,
              buttonOneTextColor: buttonOneTextColor,
              buttonTwoTextColor: buttonTwoTextColor,
              body: body,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      padding: const EdgeInsetsDirectional.all(16),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 64,
                decoration: BoxDecoration(
                  color: AppColors.filterHandleBar,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 16),
              if (imagePath != null) ...[
                SvgPicture.asset(imagePath!, height: 100),
                const SizedBox(height: 24),
              ],
              if (imageWidget != null) ...[
                imageWidget!,
                const SizedBox(height: 20),
              ],
              Text(
                title,
                style: context.t1,
              ),
              if (body != null) ...[
                body!,
              ] else ...[
                const SizedBox(height: 12),
                if (subtitle != null) ...[
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: context.b2,
                  ),
                  const SizedBox(height: 40),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CustomButton(
                        padding: const EdgeInsetsDirectional.symmetric(
                          vertical: 12,
                        ),
                        text: buttonOneText ?? '',
                        onPressed: buttonOneOnTap,
                        isLoading: isLoading,
                        borderColor: buttonOneTextColor,
                        textColor: buttonOneTextColor ?? AppColors.white,
                        backgroundColor:
                            buttonOneColor ?? AppColors.blackPrimary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        padding: const EdgeInsetsDirectional.symmetric(
                          vertical: 12,
                        ),
                        text: buttonTwoText ?? '',
                        textColor: buttonTwoTextColor ?? AppColors.white,
                        onPressed: buttonTwoOnTap,
                        isLoading: isLoading,
                        backgroundColor: buttonTwoColor ?? AppColors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
