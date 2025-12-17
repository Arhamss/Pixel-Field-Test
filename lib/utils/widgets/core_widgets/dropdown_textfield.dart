// import 'package:rentmebeach/exports.dart';

// class DropdownTextField extends StatefulWidget {
//   const DropdownTextField({
//     required this.controller,
//     required this.options,
//     this.padding = EdgeInsetsDirectional.zero,
//     this.labelText,
//     this.hintText,
//     this.validator,
//     this.onChanged,
//     this.borderRadius,
//     this.prefixIconPath,
//     this.maxHeight,
//     super.key,
//   });

//   final TextEditingController controller;
//   final List<String> options;
//   final EdgeInsetsGeometry padding;
//   final String? labelText;
//   final String? hintText;
//   final String? Function(String?)? validator;
//   final void Function(String)? onChanged;
//   final double? borderRadius;
//   final String? prefixIconPath;
//   final double? maxHeight;

//   @override
//   State<DropdownTextField> createState() => _DropdownTextFieldState();
// }

// class _DropdownTextFieldState extends State<DropdownTextField> {
//   final FocusNode _focusNode = FocusNode();
//   String? _errorText;
//   bool _isMenuOpen = false;

//   @override
//   void initState() {
//     super.initState();
//     _focusNode.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }

//   String? _validate(String? value) {
//     final error = widget.validator?.call(value);
//     setState(() {
//       _errorText = error;
//     });
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final borderColor = _errorText != null
//         ? AppColors.error
//         : (_focusNode.hasFocus || _isMenuOpen)
//         ? AppColors.primaryColor
//         : AppColors.greyShade6;

//     final iconColor = _errorText != null
//         ? AppColors.error
//         : (_focusNode.hasFocus || _isMenuOpen)
//         ? AppColors.primaryColor
//         : AppColors.secondaryColor;

//     // Create text styles in build method to avoid context issues
//     final baseTextStyle = context.b2.copyWith(
//       fontWeight: FontWeight.w700,
//       fontSize: 14,
//     );

//     return Padding(
//       padding: widget.padding,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (widget.labelText != null) ...[
//             Text(
//               widget.labelText!,
//               style: context.t1.copyWith(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w800,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             const SizedBox(height: 8),
//           ],
//           PopupMenuButton<String>(
//             position: PopupMenuPosition.under,
//             constraints: BoxConstraints(
//               minWidth: MediaQuery.of(context).size.width - 48,
//               maxWidth: MediaQuery.of(context).size.width - 48,
//             ),
//             color: AppColors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//               side: const BorderSide(
//                 color: AppColors.greyShade6,
//               ),
//             ),
//             shadowColor: Colors.black.withValues(alpha: 0.08),
//             elevation: 8,
//             onOpened: () {
//               setState(() => _isMenuOpen = true);
//               _focusNode.requestFocus();
//             },
//             onCanceled: () {
//               setState(() => _isMenuOpen = false);
//               _focusNode.unfocus();
//             },
//             child: Container(
//               padding: const EdgeInsetsDirectional.symmetric(
//                 horizontal: 16,
//                 vertical: 16,
//               ),
//               decoration: BoxDecoration(
//                 color: AppColors.white,
//                 borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
//                 border: Border.all(color: borderColor),
//               ),
//               child: Row(
//                 children: [
//                   // Prefix icon
//                   if (widget.prefixIconPath != null) ...[
//                     Padding(
//                       padding: const EdgeInsetsDirectional.only(end: 12),
//                       child: SvgPicture.asset(
//                         widget.prefixIconPath!,
//                         colorFilter: ColorFilter.mode(
//                           iconColor,
//                           BlendMode.srcIn,
//                         ),
//                       ),
//                     ),
//                   ],

//                   // Text content
//                   Expanded(
//                     child: Text(
//                       widget.controller.text.isNotEmpty
//                           ? widget.controller.text
//                           : widget.hintText ?? '',
//                       style: baseTextStyle.copyWith(
//                         color: widget.controller.text.isNotEmpty
//                             ? AppColors.textDark
//                             : AppColors.lightText,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),

//                   // Dropdown arrow
//                   const Padding(
//                     padding: EdgeInsetsDirectional.only(start: 12),
//                     child: Icon(
//                       Icons.keyboard_arrow_down,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             itemBuilder: (context) => [
//               // Single PopupMenuItem containing all options
//               PopupMenuItem<String>(
//                 enabled: false, // Disable the outer container
//                 padding: EdgeInsets.zero,
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     maxHeight: widget.maxHeight ?? 200,
//                   ),
//                   child: IntrinsicHeight(
//                     child: widget.options.length <= 4
//                         ? Padding(
//                             padding: const EdgeInsetsDirectional.symmetric(
//                               horizontal: 8,
//                               vertical: 8,
//                             ),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: widget.options.map((option) {
//                                 final isSelected =
//                                     widget.controller.text == option;
//                                 return InkWell(
//                                   onTap: () {
//                                     widget.controller.text = option;
//                                     widget.onChanged?.call(option);
//                                     _validate(option);
//                                     setState(() => _isMenuOpen = false);
//                                     _focusNode.unfocus();
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Container(
//                                     width: double.infinity,
//                                     padding:
//                                         const EdgeInsetsDirectional.symmetric(
//                                           horizontal: 16,
//                                           vertical: 12,
//                                         ),
//                                     decoration: isSelected
//                                         ? BoxDecoration(
//                                             color: AppColors
//                                                 .contactUsDropdownSelected,
//                                             border: Border.all(
//                                               color: AppColors
//                                                   .activeDetailsProgressBar,
//                                             ),
//                                             borderRadius: BorderRadius.circular(
//                                               16,
//                                             ),
//                                           )
//                                         : null,
//                                     child: Text(
//                                       option,
//                                       style: baseTextStyle.copyWith(
//                                         color: isSelected
//                                             ? AppColors.primaryColor
//                                             : AppColors.textDark,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           )
//                         : SingleChildScrollView(
//                             child: Padding(
//                               padding: const EdgeInsetsDirectional.symmetric(
//                                 horizontal: 8,
//                                 vertical: 8,
//                               ),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: widget.options.map((option) {
//                                   final isSelected =
//                                       widget.controller.text == option;
//                                   return InkWell(
//                                     onTap: () {
//                                       widget.controller.text = option;
//                                       widget.onChanged?.call(option);
//                                       _validate(option);
//                                       setState(() => _isMenuOpen = false);
//                                       _focusNode.unfocus();
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Container(
//                                       width: double.infinity,
//                                       padding:
//                                           const EdgeInsetsDirectional.symmetric(
//                                             horizontal: 16,
//                                             vertical: 12,
//                                           ),
//                                       decoration: isSelected
//                                           ? BoxDecoration(
//                                               color: AppColors
//                                                   .contactUsDropdownSelected,
//                                               border: Border.all(
//                                                 color: AppColors
//                                                     .activeDetailsProgressBar,
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(16),
//                                             )
//                                           : null,
//                                       child: Text(
//                                         option,
//                                         style: baseTextStyle.copyWith(
//                                           color: isSelected
//                                               ? AppColors.primaryColor
//                                               : AppColors.textDark,
//                                         ),
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             ),
//                           ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           if (_errorText != null) ...[
//             const SizedBox(height: 6),
//             Text(
//               _errorText!,
//               style: baseTextStyle.copyWith(
//                 color: AppColors.error,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
