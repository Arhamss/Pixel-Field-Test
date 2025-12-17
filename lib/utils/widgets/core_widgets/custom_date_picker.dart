import 'package:pixelfield_test/exports.dart';
import 'package:pixelfield_test/utils/helpers/datetime_helper.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    required this.labelText,
    required this.onDateChanged,
    this.selectedDate,
    this.hintText,
    this.iconPath,
    this.enabled = true,
    this.validator,
    this.showValidation = false,
    this.firstDate,
    this.lastDate,
    super.key,
  });

  static Future<DateTime?> show({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
  }) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDatePickerMode: initialDatePickerMode,
      builder: (context, child) {
        return Theme(data: _getCustomDatePickerTheme(context), child: child!);
      },
    );
  }

  static ThemeData _getCustomDatePickerTheme(BuildContext context) {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: AppColors.blackPrimary,
        onSurface: AppColors.blackPrimary,
      ),
      datePickerTheme: DatePickerThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        dividerColor: AppColors.blackPrimary,
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
        labelLarge: context.b1,
        headlineLarge: context.t3.copyWith(fontWeight: FontWeight.w600),
        headlineSmall: context.b1,
        bodyLarge: context.b2,
        titleSmall: context.b1,
      ),
    );
  }

  final String labelText;
  final DateTime? selectedDate;
  final void Function(DateTime) onDateChanged;
  final String? hintText;
  final String? iconPath;
  final bool enabled;
  final String? Function(String?)? validator;
  final bool showValidation;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    final dateString = selectedDate?.toIso8601String();
    final hasError =
        showValidation && validator != null && validator!(dateString) != null;

    final displayText = selectedDate != null
        ? DateTimeHelper.formatDateOfBirth(selectedDate!)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: context.b1.copyWith(color: AppColors.blackPrimary),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: enabled
              ? () async {
                  final pickedDate = await CustomDatePicker.show(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: firstDate ?? DateTime(1900),
                    lastDate: lastDate ?? DateTime.now(),
                  );
                  if (pickedDate != null) {
                    onDateChanged(pickedDate);
                  }
                }
              : null,
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: enabled ? AppColors.white : AppColors.textFieldBackground,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: enabled
                    ? (hasError ? AppColors.error : AppColors.textTertiary)
                    : AppColors.textTertiary,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    displayText ?? (hintText ?? labelText),
                    style: displayText != null
                        ? context.b2
                        : context.b2.copyWith(color: AppColors.textSecondary),
                  ),
                ),
                if (iconPath != null) ...[
                  SvgPicture.asset(
                    iconPath!,
                  ),
                ],
              ],
            ),
          ),
        ),
        if (showValidation &&
            validator != null &&
            validator!(dateString) != null) ...[
          const SizedBox(height: 6),
          Text(
            validator!(dateString)!,
            style: context.b3.copyWith(
              color: AppColors.error,
              fontSize: 13,
            ),
          ),
        ],
      ],
    );
  }
}
