import 'package:pixelfield_test/exports.dart';

class BottleStatusDropdown extends StatefulWidget {
  const BottleStatusDropdown({
    required this.items,
    required this.onChanged,
    this.initialIndex = 0,
    super.key,
  });

  final List<BottleStatusItem> items;
  final ValueChanged<int> onChanged;
  final int initialIndex;

  @override
  State<BottleStatusDropdown> createState() => _BottleStatusDropdownState();
}

class _BottleStatusDropdownState extends State<BottleStatusDropdown>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _expandAnimation;
  bool _isExpanded = false;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _selectItem(int index) {
    setState(() {
      _selectedIndex = index;
      _isExpanded = false;
      _animationController.reverse();
    });
    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    final selectedItem = widget.items[_selectedIndex];

    return Column(
      children: [
        // Selected item header
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.greyscaleBlack3,
            ),
            child: Row(
              children: [
                Image.asset(selectedItem.iconPath),
                const SizedBox(width: 8),
                Text(
                  selectedItem.title,
                  style: context.b2.copyWith(
                    color: AppColors.greyscaleGrey1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                RotationTransition(
                  turns: _rotationAnimation,
                  child: SvgPicture.asset(
                    AssetPaths.arrowDownIcon,
                    colorFilter: const ColorFilter.mode(
                      AppColors.secondary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Expandable dropdown content
        SizeTransition(
          sizeFactor: _expandAnimation,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.greyscaleBlack3,
            ),
            child: Column(
              children: [
                const Divider(
                  color: AppColors.greyscaleBlack2,
                  height: 1,
                  thickness: 1,
                ),
                ...List.generate(widget.items.length, (index) {
                  if (index == _selectedIndex) return const SizedBox.shrink();
                  final item = widget.items[index];
                  return _DropdownItem(
                    item: item,
                    onTap: () => _selectItem(index),
                    isLast: index == widget.items.length - 1,
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DropdownItem extends StatelessWidget {
  const _DropdownItem({
    required this.item,
    required this.onTap,
    this.isLast = false,
  });

  final BottleStatusItem item;
  final VoidCallback onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : const Border(
                  bottom: BorderSide(
                    color: AppColors.greyscaleBlack2,
                    width: 1,
                  ),
                ),
        ),
        child: Row(
          children: [
            Image.asset(item.iconPath),
            const SizedBox(width: 8),
            Text(
              item.title,
              style: context.b2.copyWith(
                color: AppColors.greyscaleGrey1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottleStatusItem {
  const BottleStatusItem({
    required this.title,
    required this.iconPath,
  });

  final String title;
  final String iconPath;
}
