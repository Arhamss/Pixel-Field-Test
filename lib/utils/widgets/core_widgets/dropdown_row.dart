// import 'package:rentmebeach/exports.dart';

// class DropdownRow extends StatelessWidget {
//   const DropdownRow({
//     required this.dropdownText,
//     required this.isSelected,
//     required this.onTap,
//     super.key,
//   });

//   final String dropdownText;
//   final bool isSelected;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsetsDirectional.symmetric(vertical: 4),
//         child: Container(
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? AppColors.primaryColor.withValues(alpha: 0.2)
//                 : null,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           padding:
//               const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 2),
//           child: Text(
//             dropdownText,
//             style: context.b1.copyWith(
//               color: isSelected ? AppColors.black : AppColors.disabled,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
