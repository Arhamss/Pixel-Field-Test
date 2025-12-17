import 'package:pixelfield_test/exports.dart';

class FeesSlider extends StatefulWidget {
  const FeesSlider({super.key, this.initialValue = 1, this.onChanged});

  final double initialValue;
  final ValueChanged<double>? onChanged;

  @override
  State<FeesSlider> createState() => _FeesSliderState();
}

class _FeesSliderState extends State<FeesSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Fees',
              style: context.t3.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.blackPrimary,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Text(
              'Amount: \$ ${_value.toInt()}',
              style: context.t3.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.blackPrimary,
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: SliderTheme(
            data: SliderThemeData(
              thumbSize: WidgetStateProperty.all(const Size(13, 13)),
              activeTrackColor: AppColors.blackPrimary,
              trackHeight: 4,
              inactiveTrackColor: AppColors.blackPrimary,
              thumbColor: AppColors.blackPrimary,
              overlayColor: AppColors.blackPrimary.withValues(alpha: 0.1),
            ),
            child: Slider(
              year2023: false,
              value: _value,
              min: 1,
              max: 500,
              onChanged: (value) {
                setState(() => _value = value);
                widget.onChanged?.call(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
