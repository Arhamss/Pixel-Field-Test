// import 'package:activ/exports.dart';
// import 'package:activ/l10n/localization_service.dart';
// import 'package:activ/utils/widgets/core_widgets/chips.dart';

// class ActivTitleRowWidget extends StatelessWidget {
//   const ActivTitleRowWidget({
//     required this.titleText,
//     this.onTap,
//     this.buttonText,
//     this.showButton = true,
//     super.key,
//   });

//   final String titleText;
//   final String? buttonText;
//   final VoidCallback? onTap;
//   final bool showButton;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsetsDirectional.symmetric(
//         vertical: 16,
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 titleText,
//                 style: context.b1.copyWith(
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               if (showButton)
//                 ActivChip.secondary(
//                   text: buttonText ?? Localization.viewAll,
//                   textStyle: context.b3.copyWith(
//                     color: AppColors.greenSecondary,
//                   ),
//                   onTap: onTap,
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
