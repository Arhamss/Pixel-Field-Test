import 'package:pixelfield_test/core/field_validators.dart';
import 'package:pixelfield_test/exports.dart';

/// Types of text fields supported by the CustomTextField widget
enum CustomTextFieldType { email, password, description, number, text, search }

/// Border style variants for the text field
enum TextFieldBorderStyle {
  /// Outlined border (default)
  outlined,

  /// Underline border (for dark themed screens)
  underline,
}

/// Configuration for text field styling and behavior
class TextFieldConfig {
  const TextFieldConfig({
    this.maxLines = 1,
    this.maxLength = 100,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.borderRadius = 100.0,
    this.contentPadding,
    this.inputFormatters,
  });

  final int maxLines;
  final int maxLength;
  final TextInputType keyboardType;
  final bool obscureText;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;

  /// Predefined configurations for different text field types
  static const TextFieldConfig email = TextFieldConfig(
    keyboardType: TextInputType.emailAddress,
  );

  static const TextFieldConfig password = TextFieldConfig(
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
  );

  static const TextFieldConfig description = TextFieldConfig(
    maxLines: 5,
    maxLength: 200,
    borderRadius: 18,
    contentPadding: EdgeInsetsDirectional.only(start: 16, top: 24),
  );

  static final TextFieldConfig number = TextFieldConfig(
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  );

  static const TextFieldConfig text = TextFieldConfig();

  static const TextFieldConfig search = TextFieldConfig(
    keyboardType: TextInputType.text,
  );
}

/// Configuration for text field icons
class TextFieldIconConfig {
  const TextFieldIconConfig({
    this.prefixPath,
    this.prefix,
    this.suffixPath,
    this.suffix,
    this.suffixColor,
  });

  final String? prefixPath;
  final Widget? prefix;
  final String? suffixPath;
  final Widget? suffix;
  final Color? suffixColor;
}

/// A highly customizable text field widget with built-in support for common field types
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.controller,
    this.type = CustomTextFieldType.text,
    this.config,
    this.iconConfig,
    this.padding = EdgeInsets.zero,
    this.labelText,
    this.hintText,
    this.hintColor,
    this.validator,
    this.readOnly,
    this.onTap,
    this.onChanged,
    this.enabled = true,
    this.enableRealTimeValidation = true,
    this.focusNode,
    this.suffixOnTap,
    this.prefixOnTap,
    this.onSearch,
    this.showSuffixAlways = false,
    this.filterCount,
    this.prefix,
    this.backgroundColor,
    this.textStyle,
    this.suffix,
    this.borderStyle = TextFieldBorderStyle.outlined,
    this.borderColor,
    this.labelColor,
    this.cursorColor,
    super.key,
  });

  /// Creates a number text field
  factory CustomTextField.number({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    String? Function(String?)? validator,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    bool enabled = true,
    FocusNode? focusNode,
    Key? key,
  }) {
    return CustomTextField(
      controller: controller,
      type: CustomTextFieldType.number,
      config: TextFieldConfig.number,
      labelText: labelText,
      hintText: hintText,
      validator: validator ?? FieldValidators.numberValidator,
      padding: padding,
      enabled: enabled,
      focusNode: focusNode,
      key: key,
    );
  }

  /// Creates a normal text field
  factory CustomTextField.normal({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    String? Function(String?)? validator,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    bool enabled = true,
    bool enableRealTimeValidation = false,
    FocusNode? focusNode,
    Key? key,
  }) {
    return CustomTextField(
      controller: controller,
      config: TextFieldConfig.text,
      labelText: labelText,
      hintText: hintText,
      validator: validator ?? FieldValidators.textValidator,
      padding: padding,
      enabled: enabled,
      enableRealTimeValidation: enableRealTimeValidation,
      focusNode: focusNode,
      key: key,
    );
  }

  /// Creates an email text field
  factory CustomTextField.email({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    String? Function(String?)? validator,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    bool enabled = true,
    bool enableRealTimeValidation = false,
    FocusNode? focusNode,
    TextFieldBorderStyle borderStyle = TextFieldBorderStyle.outlined,
    Color? borderColor,
    Color? labelColor,
    Color? cursorColor,
    TextStyle? textStyle,
    Color? hintColor,
    Key? key,
  }) {
    return CustomTextField(
      controller: controller,
      type: CustomTextFieldType.email,
      config: TextFieldConfig.email,
      labelText: labelText,
      hintText: hintText,
      hintColor: hintColor,
      validator: validator ?? FieldValidators.emailValidator,
      padding: padding,
      enabled: enabled,
      enableRealTimeValidation: enableRealTimeValidation,
      focusNode: focusNode,
      borderStyle: borderStyle,
      borderColor: borderColor,
      labelColor: labelColor,
      cursorColor: cursorColor,
      textStyle: textStyle,
      key: key,
    );
  }

  /// Creates a password text field
  factory CustomTextField.password({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    String? Function(String?)? validator,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    bool enabled = true,
    FocusNode? focusNode,
    TextFieldBorderStyle borderStyle = TextFieldBorderStyle.outlined,
    Color? borderColor,
    Color? labelColor,
    Color? cursorColor,
    TextStyle? textStyle,
    Color? suffixIconColor,
    Key? key,
  }) {
    return CustomTextField(
      controller: controller,
      type: CustomTextFieldType.password,
      config: TextFieldConfig.password,
      labelText: labelText,
      hintText: hintText,
      validator: validator ?? FieldValidators.passwordValidator,
      padding: padding,
      enabled: enabled,
      focusNode: focusNode,
      borderStyle: borderStyle,
      borderColor: borderColor,
      labelColor: labelColor,
      cursorColor: cursorColor,
      textStyle: textStyle,
      iconConfig: suffixIconColor != null
          ? TextFieldIconConfig(suffixColor: suffixIconColor)
          : null,
      key: key,
    );
  }

  /// Creates a description text field
  factory CustomTextField.description({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    String? Function(String?)? validator,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    bool enabled = true,
    FocusNode? focusNode,
    Key? key,
  }) {
    return CustomTextField(
      controller: controller,
      type: CustomTextFieldType.description,
      config: TextFieldConfig.description,
      labelText: labelText,
      hintText: hintText,
      validator: validator ?? FieldValidators.textValidator,
      padding: padding,
      enabled: enabled,
      focusNode: focusNode,
      key: key,
    );
  }

  /// Creates a phone number text field
  factory CustomTextField.phone({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    String? Function(String?)? validator,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    bool enabled = true,
    bool enableRealTimeValidation = false,
    FocusNode? focusNode,
    Widget? prefix,
    Key? key,
  }) {
    return CustomTextField(
      controller: controller,
      type: CustomTextFieldType.number,
      config: TextFieldConfig.number,
      labelText: labelText,
      hintText: hintText,
      validator: validator ?? FieldValidators.phoneValidator,
      padding: padding,
      enabled: enabled,
      enableRealTimeValidation: enableRealTimeValidation,
      focusNode: focusNode,
      key: key,
      prefix: prefix,
    );
  }

  /// Creates a search text field
  factory CustomTextField.search({
    required TextEditingController controller,
    String? hintText,
    void Function(String)? onChanged,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    bool enabled = true,
    FocusNode? focusNode,
    VoidCallback? suffixOnTap,
    VoidCallback? prefixOnTap,
    VoidCallback? onSearch,
    bool showSuffixAlways = false,
    int? filterCount,
    Key? key,
  }) {
    return CustomTextField(
      controller: controller,
      type: CustomTextFieldType.search,
      config: TextFieldConfig.search,
      hintText: hintText,
      onChanged: onChanged,
      padding: padding,
      enabled: enabled,
      focusNode: focusNode,
      suffixOnTap: suffixOnTap,
      prefixOnTap: prefixOnTap,
      onSearch: onSearch,
      showSuffixAlways: showSuffixAlways,
      filterCount: filterCount,
      key: key,
    );
  }

  /// Controller for the text field
  final TextEditingController controller;

  /// Type of text field (determines default configuration)
  final CustomTextFieldType type;

  /// Custom configuration for styling and behavior
  final TextFieldConfig? config;

  /// Configuration for icons
  final TextFieldIconConfig? iconConfig;

  /// Padding around the text field
  final EdgeInsetsGeometry padding;

  /// Label text displayed above the field
  final String? labelText;

  /// Hint text displayed inside the field
  final String? hintText;

  /// Color of the hint text
  final Color? hintColor;

  /// Validation function
  final String? Function(String?)? validator;

  /// Whether the field is read-only
  final bool? readOnly;

  /// Callback when the field is tapped
  final VoidCallback? onTap;

  /// Callback when the text changes
  final void Function(String)? onChanged;

  /// Whether the field is enabled
  final bool enabled;

  /// Whether to validate in real-time
  final bool enableRealTimeValidation;

  /// Optional focus node
  final FocusNode? focusNode;

  /// Callback when the suffix icon is tapped
  final VoidCallback? suffixOnTap;

  /// Callback when the prefix icon is tapped
  final VoidCallback? prefixOnTap;

  /// Callback when search action is triggered (keyboard search button or prefix tap)
  final VoidCallback? onSearch;

  /// Whether to show suffix icon always (for search field)
  final bool showSuffixAlways;

  /// Filter count to display as badge on suffix icon
  final int? filterCount;

  /// Custom prefix widget (overrides iconConfig.prefixPath)
  final Widget? prefix;

  /// Background color of the text field
  final Color? backgroundColor;

  /// Text style for the input text
  final TextStyle? textStyle;

  /// Custom suffix widget (overrides iconConfig.suffixPath)
  final Widget? suffix;

  /// Border style (outlined or underline)
  final TextFieldBorderStyle borderStyle;

  /// Border color for the text field
  final Color? borderColor;

  /// Label text color
  final Color? labelColor;

  /// Cursor color
  final Color? cursorColor;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode _focusNode;
  late final bool _isExternalFocusNode;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _isExternalFocusNode = widget.focusNode != null;
    _focusNode = widget.focusNode ?? FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_focusNode.hasFocus) {
        _focusNode.canRequestFocus = true;
      }
    });
  }

  @override
  void dispose() {
    if (!_isExternalFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  /// Gets the effective configuration for this text field
  TextFieldConfig get _effectiveConfig {
    return widget.config ?? _getDefaultConfigForType(widget.type);
  }

  /// Gets the effective icon configuration for this text field
  TextFieldIconConfig get _effectiveIconConfig {
    return widget.iconConfig ?? const TextFieldIconConfig();
  }

  /// Gets default configuration based on field type
  TextFieldConfig _getDefaultConfigForType(CustomTextFieldType type) {
    switch (type) {
      case CustomTextFieldType.email:
        return TextFieldConfig.email;
      case CustomTextFieldType.password:
        return TextFieldConfig.password;
      case CustomTextFieldType.description:
        return TextFieldConfig.description;
      case CustomTextFieldType.number:
        return TextFieldConfig.number;
      case CustomTextFieldType.search:
        return TextFieldConfig.search;
      case CustomTextFieldType.text:
        return TextFieldConfig.text;
    }
  }

  /// Handles text changes
  void _onChanged(String value) {
    widget.onChanged?.call(value);
  }

  /// Toggles password visibility
  void _togglePasswordVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  /// Creates the border decoration
  InputBorder _createBorder(Color color, {double width = 1.0}) {
    if (widget.borderStyle == TextFieldBorderStyle.underline) {
      return UnderlineInputBorder(
        borderSide: BorderSide(color: color, width: width),
      );
    }
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.all(
        Radius.circular(_effectiveConfig.borderRadius),
      ),
    );
  }

  /// Creates the error border
  InputBorder _createErrorBorder() {
    if (widget.borderStyle == TextFieldBorderStyle.underline) {
      return const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.error),
      );
    }
    return OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.error),
      borderRadius: BorderRadius.all(
        Radius.circular(_effectiveConfig.borderRadius),
      ),
    );
  }

  /// Builds the prefix icon widget
  Widget? _buildPrefixIcon() {
    if (widget.prefix != null) {
      return widget.prefix;
    }
    if (widget.type == CustomTextFieldType.search) {
      return _buildSearchPrefixIcon();
    }

    final iconConfig = _effectiveIconConfig;
    if (iconConfig.prefix != null) {
      return iconConfig.prefix;
    }

    if (iconConfig.prefixPath != null) {
      return _buildIconFromPath(
        iconConfig.prefixPath!,
        const EdgeInsetsDirectional.only(bottom: 8, top: 8, start: 16, end: 8),
      );
    }

    return null;
  }

  /// Builds the search prefix icon
  Widget _buildSearchPrefixIcon() {
    return GestureDetector(
      onTap: widget.prefixOnTap ?? widget.onSearch,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          bottom: 8,
          top: 8,
          start: 16,
          end: 8,
        ),
        child: SvgPicture.asset(AssetPaths.dummyIcon),
      ),
    );
  }

  /// Builds the suffix icon widget
  Widget? _buildSuffixIcon() {
    if (widget.suffix != null) {
      return widget.suffix;
    }
    // if (widget.type == CustomTextFieldType.search) {
    //   return _buildSearchSuffixIcon();
    // }

    if (widget.type == CustomTextFieldType.password) {
      return _buildPasswordSuffixIcon();
    }

    final iconConfig = _effectiveIconConfig;
    if (iconConfig.suffix != null) {
      return iconConfig.suffix;
    }

    if (iconConfig.suffixPath != null) {
      return _buildIconFromPath(
        iconConfig.suffixPath!,
        const EdgeInsets.symmetric(horizontal: 12),
        color: iconConfig.suffixColor,
      );
    }

    return null;
  }

  /// Builds the password suffix icon
  Widget _buildPasswordSuffixIcon() {
    final iconColor = _effectiveIconConfig.suffixColor;
    return GestureDetector(
      onTap: _togglePasswordVisibility,
      child: Padding(
        padding: widget.borderStyle == TextFieldBorderStyle.underline
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 12),
        child: SvgPicture.asset(
          _obscureText ? AssetPaths.eyeOpenIcon : AssetPaths.eyeOpenIcon,
          colorFilter: iconColor != null
              ? ColorFilter.mode(iconColor, BlendMode.srcIn)
              : null,
        ),
      ),
    );
  }

  /// Builds an icon from asset path with custom padding and color
  Widget _buildIconFromPath(
    String path,
    EdgeInsetsGeometry padding, {
    Color? color,
  }) {
    return Padding(
      padding: padding,
      child: SvgPicture.asset(
        path,
        width: 16,
        colorFilter: color != null
            ? ColorFilter.mode(color, BlendMode.srcIn)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = _effectiveConfig;
    final isUnderline = widget.borderStyle == TextFieldBorderStyle.underline;

    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.labelText != null) ...[
            Text(
              widget.labelText!,
              style: context.l1.copyWith(
                color: widget.labelColor ?? AppColors.blackPrimary,
              ),
            ),
            const SizedBox(height: 8),
          ],
          ListenableBuilder(
            listenable: _focusNode,
            builder: (context, child) {
              final hasFocus = _focusNode.hasFocus;
              final effectiveBorderColor =
                  widget.borderColor ?? _getBorderColorFromFocus(hasFocus);
              return TextFormField(
                cursorWidth: 1.5,
                cursorHeight: 22,
                controller: widget.controller,
                focusNode: _focusNode,
                enabled: widget.enabled,
                readOnly: widget.readOnly ?? false,
                obscureText: config.obscureText ? _obscureText : false,
                obscuringCharacter: '●',
                keyboardType: config.keyboardType,
                textInputAction: widget.type == CustomTextFieldType.search
                    ? TextInputAction.search
                    : TextInputAction.done,
                maxLines: config.maxLines,
                maxLength: config.maxLength,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                inputFormatters: config.inputFormatters,
                style: widget.textStyle ?? context.b2,
                cursorColor: widget.cursorColor ?? AppColors.blackPrimary,
                autovalidateMode: widget.enableRealTimeValidation
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                onChanged: _onChanged,
                onFieldSubmitted: widget.type == CustomTextFieldType.search
                    ? (_) => widget.onSearch?.call()
                    : null,
                validator: widget.validator,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  filled: !isUnderline,
                  fillColor: isUnderline
                      ? Colors.transparent
                      : hasFocus
                          ? AppColors.textFieldBackground
                          : widget.backgroundColor ?? AppColors.white,
                  hintStyle: context.b2.copyWith(
                    color: widget.hintColor ?? AppColors.textSecondary,
                  ),
                  counterText: '',
                  border: _createBorder(effectiveBorderColor),
                  enabledBorder: _createBorder(effectiveBorderColor),
                  focusedBorder: _createBorder(effectiveBorderColor, width: 2),
                  errorBorder: _createErrorBorder(),
                  focusedErrorBorder: _createErrorBorder(),
                  errorStyle: context.b3.copyWith(
                    color: AppColors.error,
                    fontSize: 13,
                  ),
                  errorMaxLines: 3,
                  prefixIcon: _buildPrefixIcon(),
                  suffixIcon: _buildSuffixIcon() != null
                      ? GestureDetector(
                          onTap: widget.suffixOnTap,
                          child: _buildSuffixIcon(),
                        )
                      : null,
                  contentPadding: config.contentPadding ??
                      (isUnderline
                          ? const EdgeInsets.only(bottom: 8)
                          : const EdgeInsets.all(12)),
                  suffixIconConstraints: isUnderline
                      ? const BoxConstraints(maxHeight: 24, maxWidth: 24)
                      : null,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Gets the border color based on focus state (for ValueListenableBuilder)
  Color _getBorderColorFromFocus(bool hasFocus) {
    if (!widget.enabled) return AppColors.textTertiary;
    if (hasFocus) return AppColors.blackPrimary;
    return AppColors.textTertiary;
  }
}
