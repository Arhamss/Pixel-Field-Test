import 'package:flutter/cupertino.dart';
import 'package:pixelfield_test/exports.dart';

enum RMBDatePickerMode {
  past, // Can't pick dates after now
  future, // Can't pick dates before now
}

class RMBDatePicker extends StatefulWidget {
  const RMBDatePicker({
    required this.onDateSelected,
    this.mode = RMBDatePickerMode.past,
    super.key,
    this.firstDate,
    this.lastDate,
    this.initialDate,
  });

  final dynamic Function(DateTime) onDateSelected;
  final RMBDatePickerMode mode;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;

  @override
  State<RMBDatePicker> createState() => _RMBDatePickerState();
}

class _RMBDatePickerState extends State<RMBDatePicker> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final firstDate = widget.mode == RMBDatePickerMode.past
        ? widget.firstDate ?? DateTime(1900)
        : now;
    final lastDate = widget.mode == RMBDatePickerMode.past
        ? now
        : widget.lastDate ?? DateTime(2100);

    final initialDate = widget.initialDate ?? now;
    final validInitialDate = initialDate.isBefore(firstDate)
        ? firstDate
        : initialDate.isAfter(lastDate)
        ? lastDate
        : initialDate;

    return SizedBox(
      height: 200,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: validInitialDate,
        minimumDate: firstDate,
        maximumDate: lastDate,
        onDateTimeChanged: widget.onDateSelected,
        backgroundColor: AppColors.white,
      ),
    );
  }
}
