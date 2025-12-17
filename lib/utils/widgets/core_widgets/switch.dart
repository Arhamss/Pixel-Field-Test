import 'package:pixelfield_test/exports.dart';

class RMBSwitch extends StatelessWidget {
  const RMBSwitch({
    required this.switchValue,
    required this.onSwitchChanged,
    this.title,
    this.backgroundColor,
    super.key,
  });

  final String? title;
  final bool switchValue;
  final ValueChanged<bool> onSwitchChanged;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor ?? AppColors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title != null)
            Text(
              title!,
              style: context.t3.copyWith(color: AppColors.blackPrimary),
            ),
          Transform.scale(
            scale: 0.75,
            child: Switch(
              value: switchValue,
              onChanged: onSwitchChanged,
              activeColor: AppColors.blackPrimary,
              activeTrackColor: AppColors.blackPrimary,
              inactiveTrackColor: AppColors.blackPrimary,
              inactiveThumbColor: AppColors.blackPrimary,
              trackOutlineColor: WidgetStateProperty.all(
                AppColors.blackPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
