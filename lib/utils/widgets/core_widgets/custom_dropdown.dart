import 'package:pixelfield_test/exports.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
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
    this.onTap,
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
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomDropdownCubit(),
      child: _CustomDropdownContent(
        labelText: labelText,
        options: options,
        onChanged: onChanged,
        selectedValue: selectedValue,
        hintText: hintText,
        prefixIconPath: prefixIconPath,
        borderRadius: borderRadius,
        maxHeight: maxHeight,
        enabled: enabled,
        validator: validator,
        showValidation: showValidation,
        onTap: onTap,
      ),
    );
  }
}

class _CustomDropdownContent extends StatefulWidget {
  const _CustomDropdownContent({
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
    this.onTap,
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
  final VoidCallback? onTap;

  @override
  State<_CustomDropdownContent> createState() => _CustomDropdownContentState();
}

class _CustomDropdownContentState extends State<_CustomDropdownContent> {
  final FocusNode _focusNode = FocusNode();
  final GlobalKey _dropdownKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      // Close dropdown when focus is lost (tapping outside)
      context.read<CustomDropdownCubit>().closeDropdown();
    }
  }

  void _validateField(CustomDropdownCubit cubit) {
    if (widget.validator != null && widget.showValidation) {
      final error = widget.validator!(widget.selectedValue);
      cubit.setError(error);
    } else {
      cubit.clearError();
    }
  }

  void _selectOption(CustomDropdownCubit cubit, String option) {
    widget.onChanged(option);
    cubit.closeDropdown();
    _validateField(cubit);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomDropdownCubit, CustomDropdownState>(
      listener: (context, state) {
        if (widget.showValidation) {
          _validateField(context.read<CustomDropdownCubit>());
        }
      },
      builder: (context, state) {
        final cubit = context.read<CustomDropdownCubit>();
        final hasValue =
            widget.selectedValue != null && widget.selectedValue!.isNotEmpty;
        final hasError = state.errorText != null;

        final borderColor = !widget.enabled
            ? AppColors.textTertiary
            : hasError
            ? AppColors.error
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
              onTap: widget.enabled
                  ? () {
                      widget.onTap?.call();
                      // Always open the dropdown when tapped, regardless of current state
                      if (!state.isOpen) {
                        cubit.openDropdown();
                        _focusNode.requestFocus();
                      }
                    }
                  : null,
              child: Focus(
                focusNode: _focusNode,
                child: Container(
                  key: _dropdownKey,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                      state.isOpen ? 16 : widget.borderRadius,
                    ),
                    border: Border.all(color: borderColor),
                  ),
                  child: Column(
                    children: [
                      Padding(
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
                              child: Text(
                                hasValue
                                    ? widget.selectedValue!
                                    : (widget.hintText ?? widget.labelText),
                                style: hasValue
                                    ? context.b2
                                    : context.b2.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                              ),
                            ),
                            AnimatedRotation(
                              turns: state.isOpen ? 0.5 : 0,
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
                      if (state.isOpen && widget.options.isNotEmpty) ...[
                        const Divider(
                          color: AppColors.textTertiary,
                          height: 1,
                          thickness: 1,
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: widget.maxHeight,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const ClampingScrollPhysics(),
                            itemCount: widget.options.length,
                            itemBuilder: (context, index) {
                              final option = widget.options[index];
                              final isSelected = widget.selectedValue == option;

                              return InkWell(
                                onTap: () => _selectOption(cubit, option),
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
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
                      ],
                    ],
                  ),
                ),
              ),
            ),
            if (hasError) ...[
              const SizedBox(height: 6),
              Text(
                state.errorText!,
                style: context.b3.copyWith(
                  color: AppColors.error,
                  fontSize: 13,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
