// import 'package:activ/exports.dart';

// class ActivPopupMenuButton extends StatelessWidget {
//   const ActivPopupMenuButton({
//     required this.buttonOneText,
//     required this.buttonOneOnTap,
//     super.key,
//     this.buttonTwoText,
//     this.buttonTwoOnTap,
//     this.icon,
//     this.buttonOneTextStyle,
//     this.buttonTwoTextStyle,
//     this.offset = const Offset(0, 40),
//     this.buttonBackgroundColor = AppColors.iconBackground,
//   });

//   final String buttonOneText;
//   final VoidCallback buttonOneOnTap;
//   final String? buttonTwoText;
//   final VoidCallback? buttonTwoOnTap;
//   final Widget? icon;
//   final TextStyle? buttonOneTextStyle;
//   final TextStyle? buttonTwoTextStyle;
//   final Offset offset;
//   final Color buttonBackgroundColor;

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<String>(
//       clipBehavior: Clip.antiAlias,
//       enableFeedback: false,
//       elevation: 2,
//       style: ButtonStyle(
//         backgroundColor: WidgetStateProperty.all(buttonBackgroundColor),
//         minimumSize: WidgetStateProperty.all(Size.zero),
//         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         overlayColor: WidgetStateProperty.all(Colors.transparent),
//         padding: WidgetStateProperty.all(const EdgeInsetsDirectional.all(12)),
//         splashFactory: NoSplash.splashFactory,
//       ),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       menuPadding: EdgeInsetsDirectional.zero,
//       padding: EdgeInsetsDirectional.zero,
//       color: AppColors.white,
//       onSelected: (value) {
//         if (value == 'buttonOne') {
//           buttonOneOnTap();
//         } else if (value == 'buttonTwo' && buttonTwoOnTap != null) {
//           buttonTwoOnTap!();
//         }
//       },
//       itemBuilder: (BuildContext context) {
//         final menuItems = <PopupMenuEntry<String>>[
//           PopupMenuItem<String>(
//             height: 40,
//             value: 'buttonOne',
//             child: Center(
//               child: Text(
//                 buttonOneText,
//                 style: buttonOneTextStyle ?? context.b2,
//               ),
//             ),
//           ),
//         ];

//         if (buttonTwoText != null) {
//           menuItems.add(
//             PopupMenuItem<String>(
//               height: 40,
//               value: 'buttonTwo',
//               child: Center(
//                 child: Text(
//                   buttonTwoText!,
//                   style: buttonTwoTextStyle ??
//                       context.b2.copyWith(
//                         color: AppColors.error,
//                       ),
//                 ),
//               ),
//             ),
//           );
//         }

//         return menuItems;
//       },
//       icon: icon ?? SvgPicture.asset(AssetPaths.menuIcon),
//       offset: offset,
//     );
//   }
// }
