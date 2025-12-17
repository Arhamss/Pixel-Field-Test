import 'package:pixelfield_test/exports.dart';

class SlidingTab extends StatefulWidget {
  const SlidingTab({
    required this.labels,
    required this.onTapCallbacks,
    this.height,
    this.width,
    this.selectedColor,
    this.backgroundColor,
    this.borderColor,
    this.initialIndex = 0,
    this.shortenWidth = false,
    this.borderRadius = 100,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.textStyle,
    this.padding,
    super.key,
  }) : assert(
         labels.length == onTapCallbacks.length &&
             (labels.length == 2 || labels.length == 3),
         'labels and onTapCallbacks must be of equal length and contain either 2 or 3 items.',
       );

  final List<String> labels;
  final List<VoidCallback> onTapCallbacks;
  final double? height;
  final double? width;
  final Color? selectedColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final int initialIndex;
  final bool shortenWidth;
  final double borderRadius;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  @override
  State<SlidingTab> createState() => _SlidingTabState();
}

class _SlidingTabState extends State<SlidingTab> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  void didUpdateWidget(SlidingTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialIndex != oldWidget.initialIndex) {
      selectedIndex = widget.initialIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabCount = widget.labels.length;
    const margin = 4.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final containerWidth = widget.width ?? constraints.maxWidth;
        final tabWidth = (containerWidth - margin * 2) / tabCount;

        return Container(
          width: widget.width,
          height: widget.height ?? 48,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? AppColors.blackPrimary,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: widget.borderColor != null
                ? Border.all(color: widget.borderColor!)
                : null,
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: margin + (selectedIndex * tabWidth),
                top: margin,
                bottom: margin,
                width: tabWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.selectedColor ?? AppColors.blackPrimary,
                    borderRadius:
                        BorderRadius.circular(widget.borderRadius - margin),
                  ),
                ),
              ),
              Row(
                children: List.generate(tabCount, (index) {
                  final isSelected = selectedIndex == index;
                  final textColor = isSelected
                      ? widget.selectedTextColor ?? AppColors.white
                      : widget.unselectedTextColor ?? AppColors.white;
                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        widget.onTapCallbacks[index]();
                      },
                      child: Container(
                        height: widget.height ?? 48,
                        alignment: Alignment.center,
                        child: Text(
                          widget.labels[index],
                          textAlign: TextAlign.center,
                          style: (widget.textStyle ?? context.b3).copyWith(
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
