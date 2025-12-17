import 'package:pixelfield_test/exports.dart';

class CustomSlidingTab extends StatefulWidget {
  const CustomSlidingTab({
    required this.tabs,
    required this.onTabChanged,
    this.selectedIndex = 0,
    this.height = 40,
    this.backgroundColor,
    this.selectedColor,
    this.borderRadius = 12,
    this.textStyle,
    this.selectedTextStyle,
    this.animationDuration = const Duration(milliseconds: 300),
    super.key,
  });

  final List<SlidingTabItem> tabs;
  final void Function(int) onTabChanged;
  final int selectedIndex;
  final double height;
  final Color? backgroundColor;
  final Color? selectedColor;
  final double borderRadius;
  final TextStyle? textStyle;
  final TextStyle? selectedTextStyle;
  final Duration animationDuration;

  @override
  State<CustomSlidingTab> createState() => _CustomSlidingTabState();
}

class _CustomSlidingTabState extends State<CustomSlidingTab> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(CustomSlidingTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _selectedIndex = widget.selectedIndex;
    }
  }

  void _onTabTap(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      widget.onTabChanged(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? AppColors.blackPrimary,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: widget.animationDuration,
            alignment: Alignment(
              -1.0 + (2.0 * _selectedIndex / (widget.tabs.length - 1)),
              0,
            ),
            child: Container(
              width:
                  (MediaQuery.of(context).size.width -
                      (MediaQuery.of(context).size.width * 0.2)) /
                  widget.tabs.length,
              height: widget.height,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: widget.selectedColor ?? AppColors.blackPrimary,
                borderRadius: BorderRadius.circular(widget.borderRadius - 2),
              ),
            ),
          ),
          Row(
            children: List.generate(widget.tabs.length, (index) {
              final isSelected = _selectedIndex == index;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _onTabTap(index),
                  child: Container(
                    height: widget.height,
                    alignment: Alignment.center,
                    child: AnimatedDefaultTextStyle(
                      duration: widget.animationDuration,
                      style: isSelected
                          ? (widget.selectedTextStyle ??
                                (widget.textStyle ?? context.b1).copyWith(
                                  color: AppColors.white,
                                ))
                          : (widget.textStyle ?? context.b1).copyWith(
                              color: AppColors.blackPrimary,
                            ),
                      child: Text(
                        widget.tabs[index].label,
                        textAlign: TextAlign.center,
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
  }
}

class SlidingTabItem {
  const SlidingTabItem({required this.label, this.value});

  final String label;
  final dynamic value;

  @override
  String toString() => 'SlidingTabItem(label: $label, value: $value)';
}
