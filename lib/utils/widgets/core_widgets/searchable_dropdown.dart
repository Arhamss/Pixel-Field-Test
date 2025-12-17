import 'package:pixelfield_test/exports.dart';

class SearchableDropdown extends StatefulWidget {
  const SearchableDropdown({
    required this.labelText,
    required this.options,
    required this.onChanged,
    this.selectedValue,
    this.hintText,
    this.prefixIconPath,
    this.borderRadius = 100.0,
    this.maxHeight = 200.0,
    this.enabled = true,
    this.validator,
    this.showValidation = false,
    super.key,
  });

  final String labelText;
  final List<String> options;
  final void Function(String) onChanged;
  final String? selectedValue;
  final String? hintText;
  final String? prefixIconPath;
  final double borderRadius;
  final double maxHeight;
  final bool enabled;
  final String? Function(String?)? validator;
  final bool showValidation;

  @override
  State<SearchableDropdown> createState() => SearchableDropdownState();
}

class SearchableDropdownState extends State<SearchableDropdown> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late CustomDropdownCubit _cubit;
  List<String> _filteredOptions = [];
  final GlobalKey _dropdownKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _cubit = CustomDropdownCubit();
    _filteredOptions = widget.options;

    if (widget.selectedValue != null) {
      _searchController.text = widget.selectedValue!;
    }

    _searchController.addListener(_onSearchChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(SearchableDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.options != oldWidget.options) {
      _filteredOptions = widget.options;
      _filterOptions();
    }

    if (widget.selectedValue != oldWidget.selectedValue) {
      _searchController.text = widget.selectedValue ?? '';
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _searchController.dispose();
    _focusNode.dispose();
    _cubit.close();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterOptions();
    if (_overlayEntry != null) {
      _showOverlay(); // Rebuild overlay with new filtered options
    }
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _cubit.openDropdown();
      _showOverlay();
    } else {
      // Validate that the entered text matches an option
      _validateSelectedValue();
      _removeOverlay();
    }
  }

  void _filterOptions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredOptions = widget.options.where((option) {
        return option.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _validateSelectedValue() {
    final enteredText = _searchController.text.trim();

    // If text is entered but doesn't match any option, clear it
    if (enteredText.isNotEmpty && !widget.options.contains(enteredText)) {
      _searchController.clear();
      widget.onChanged('');
      _cubit.closeDropdown();
      return;
    }

    // If text matches an option, select it
    if (enteredText.isNotEmpty && widget.options.contains(enteredText)) {
      widget.onChanged(enteredText);
    }

    _cubit.closeDropdown();
  }

  void _selectOption(String option) {
    _searchController.text = option;
    widget.onChanged(option);
    _cubit.closeDropdown();
    _focusNode.unfocus();
    _removeOverlay();
  }

  void _validateField() {
    if (widget.validator != null && widget.showValidation) {
      final error = widget.validator!(widget.selectedValue);
      _cubit.setError(error);
    } else {
      _cubit.clearError();
    }
  }

  void _showOverlay() {
    _removeOverlay();

    final overlay = Overlay.of(context);
    final renderBox =
    _dropdownKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) =>
          Stack(
            children: [
              // Invisible full-screen tap detector to close on outside tap
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    _removeOverlay();
                    _cubit.closeDropdown();
                    _focusNode.unfocus();
                  },
                  child: Container(color: Colors.transparent),
                ),
              ),
              // The actual dropdown content
              Positioned(
                left: offset.dx,
                top: offset.dy + size.height,
                width: size.width,
                child: Material(
                  child: Container(
                    constraints: BoxConstraints(maxHeight: widget.maxHeight),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.textTertiary),
                    ),
                    child: _filteredOptions.isEmpty
                        ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'No cities found',
                        style: context.b2.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    )
                        : ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const ClampingScrollPhysics(),
                      itemCount: _filteredOptions.length,
                      itemBuilder: (context, index) {
                        final option = _filteredOptions[index];
                        final isSelected = widget.selectedValue == option;

                        return InkWell(
                          onTap: () => _selectOption(option),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    option,
                                    style: context.b2.copyWith(
                                      color: AppColors.blackPrimary,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: AppColors.blackPrimary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      AssetPaths.dummyIcon,
                                      width: 14,
                                      height: 14,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  /// Public method to close the dropdown
  void closeDropdown() {
    _removeOverlay();
    _cubit.closeDropdown();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<CustomDropdownCubit, CustomDropdownState>(
        listener: (context, state) {
          if (widget.showValidation) {
            _validateField();
          }
        },
        builder: (context, state) {
          final hasError = state.errorText != null;
          final isOpen = state.isOpen;

          final borderColor = !widget.enabled
              ? AppColors.textTertiary
              : hasError
              ? AppColors.error
              : isOpen
              ? AppColors.blackPrimary
              : AppColors.textTertiary;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.labelText,
                style: context.b1.copyWith(color: AppColors.blackPrimary),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  if (widget.enabled) {
                    if (isOpen) {
                      _removeOverlay();
                      _cubit.closeDropdown();
                      _focusNode.unfocus();
                    } else {
                      _focusNode.requestFocus();
                    }
                  }
                },
                child: Container(
                  key: _dropdownKey,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    border: Border.all(color: borderColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        if (widget.prefixIconPath != null) ...[
                          SvgPicture.asset(
                            widget.prefixIconPath!,
                            width: 16,
                            colorFilter: ColorFilter.mode(
                              widget.enabled
                                  ? AppColors.blackPrimary
                                  : AppColors.textTertiary,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: SizedBox(
                            height: 20, // Match the height of Text widget
                            child: TextField(
                              controller: _searchController,
                              focusNode: _focusNode,
                              enabled: widget.enabled,
                              decoration: InputDecoration(
                                hintText: widget.hintText ?? widget.labelText,
                                hintStyle: context.b2.copyWith(
                                  color: AppColors.textTertiary,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                              ),
                              style: context.b2.copyWith(
                                color: AppColors.blackPrimary,
                              ),
                            ),
                          ),
                        ),
                        AnimatedRotation(
                          turns: isOpen ? 0.5 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: SvgPicture.asset(
                            AssetPaths.dummyIcon,
                            colorFilter: ColorFilter.mode(
                              widget.enabled
                                  ? AppColors.blackPrimary
                                  : AppColors.textTertiary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
