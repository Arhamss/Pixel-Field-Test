import 'package:flutter/cupertino.dart';
import 'package:pixelfield_test/exports.dart';

class RMBTimePicker extends StatefulWidget {
  const RMBTimePicker({
    required this.onTimeSelected,
    super.key,
    this.initialTime,
  });

  final dynamic Function(DateTime) onTimeSelected;

  final DateTime? initialTime;

  @override
  State<RMBTimePicker> createState() => _RMBTimePickerState();
}

class _RMBTimePickerState extends State<RMBTimePicker> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return SizedBox(
      height: 200,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: widget.initialTime ?? now,
        onDateTimeChanged: widget.onTimeSelected,
        backgroundColor: AppColors.white,
      ),
    );
  }
}
