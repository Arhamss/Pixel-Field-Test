// import 'dart:io';

// import 'package:rentmebeach/core/permissions/permission_manager.dart';
// import 'package:rentmebeach/exports.dart';

// class CustomDialog {
//   static void showOpenSettingsDialog({
//     required BuildContext context,
//     required String title,
//   }) {
//     showAdaptiveDialog<dynamic>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: AppColors.white,
//           title: Text(
//             title,
//             style: context.b1,
//             textAlign: TextAlign.center,
//           ),
//           actions: [
//             rentmebeachButton(
//               text: 'Open Settings',
//               onPressed: () async {
//                 await PermissionManager.openAppSettingsPage();
//               },
//               isLoading: false,
//             ),
//           ],
//         );
//       },
//     );
//   }

//   static void showLogoutDialog({
//     required BuildContext context,
//     required String title,
//     required String message,
//     required String confirmText,
//     required VoidCallback onConfirm,
//   }) {
//     showDialog<dynamic>(
//       context: context,
//       barrierColor: AppColors.black.withValues(alpha: 0.7),
//       builder: (context) {
//         return AlertDialog(
//           insetPadding: const EdgeInsets.all(22),
//           actionsPadding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
//           contentPadding: const EdgeInsetsDirectional.all(16),
//           titlePadding: const EdgeInsetsDirectional.only(top: 16),
//           buttonPadding: const EdgeInsetsDirectional.all(0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           backgroundColor: AppColors.white,
//           title: Text(
//             title,
//             style: context.h2.copyWith(
//               fontWeight: FontWeight.w800,
//               fontSize: 22,
//               color: AppColors.textPrimary,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           content: Text(
//             message,
//             style: context.b1.copyWith(
//               color: AppColors.textPrimary,
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           actionsAlignment: MainAxisAlignment.center,
//           actions: [
//             // Confirm Button
//             rentmebeachButton(
//               textStyle: context.b2.copyWith(
//                 color: AppColors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//               ),
//               text: confirmText,
//               onPressed: () {
//                 onConfirm();
//               },
//               backgroundColor: AppColors.activeDetailsProgressBar,
//               isLoading: false,
//             ),
//             const SizedBox(height: 8),
//           ],
//         );
//       },
//     );
//   }

//   static void showLoadingDialog({
//     required BuildContext context,
//   }) {
//     showDialog<dynamic>(
//       context: context,
//       barrierColor: AppColors.black.withValues(alpha: 0.7),
//       builder: (context) {
//         return const PopScope(
//           canPop: false,
//           child: Center(
//             child: LoadingWidget(),
//           ),
//         );
//       },
//     );
//   }

//   static void showPermissionDialog({
//     required BuildContext context,
//     required String title,
//     required String message,
//   }) {
//     showDialog<dynamic>(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//       ),
//     );
//   }

//   static void showFullImage({
//     required BuildContext context,
//     required File imageFile,
//   }) {
//     showDialog<dynamic>(
//       context: context,
//       barrierColor: AppColors.black.withValues(alpha: 0.7),
//       builder: (context) {
//         return Stack(
//           children: [
//             Image.file(
//               imageFile,
//               width: MediaQuery.sizeOf(context).width,
//               height: MediaQuery.sizeOf(context).height,
//               fit: BoxFit.fitWidth,
//             ),
//             Positioned(
//               top: 10,
//               right: 10,
//               child: GestureDetector(
//                 onTap: context.pop,
//                 child: const Icon(
//                   Icons.highlight_remove,
//                   size: 45,
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   static void showConfirmationDialog({
//     required BuildContext context,
//     required String title,
//     required String message,
//     required String confirmText,
//     required VoidCallback onConfirm,
//     String cancelText = 'Cancel',
//   }) {
//     showDialog<dynamic>(
//       context: context,
//       barrierColor: AppColors.black.withValues(alpha: 0.7),
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           backgroundColor: Colors.white,
//           title: Text(
//             title,
//             style: context.h2.copyWith(
//               fontWeight: FontWeight.w600,
//               color: AppColors.black,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           content: Text(
//             message,
//             style: context.b1.copyWith(
//               color: AppColors.textSecondary,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           actionsAlignment: MainAxisAlignment.center,
//           actions: [
//             // Confirm Button
//             rentmebeachButton(
//               text: confirmText,
//               onPressed: () {
//                 Navigator.pop(context); // Close the dialog
//                 onConfirm(); // Execute the confirm action
//               },
//               backgroundColor: Colors.redAccent,
//               isLoading: false,
//             ),
//             const SizedBox(height: 8),
//             // Cancel Button
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the dialog
//               },
//               child: Text(
//                 cancelText,
//                 style: context.b2.copyWith(
//                   color: AppColors.textSecondary,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   static void showActionDialog({
//     required String svgAssetPath,
//     required BuildContext context,
//     required String title,
//     required String message,
//     required String confirmText,
//     required VoidCallback onConfirm,
//     String cancelText = 'Cancel',
//     bool isLoading = false,
//     bool isDanger = false,
//   }) {
//     showDialog<dynamic>(
//       context: context,
//       barrierDismissible: !isLoading,
//       barrierColor: AppColors.black.withValues(alpha: 0.7),
//       builder: (context) {
//         return Dialog(
//           insetPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 24,
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             padding: const EdgeInsetsDirectional.fromSTEB(24, 24, 24, 16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SvgPicture.asset(
//                   svgAssetPath,
//                 ),
//                 const SizedBox(height: 24),
//                 Text(
//                   title,
//                   style: context.h2.copyWith(
//                     color: AppColors.textPrimary,
//                     fontWeight: FontWeight.w800,
//                     fontSize: 22,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 Text(
//                   textAlign: TextAlign.center,
//                   message,
//                   style: context.b1.copyWith(
//                     color: AppColors.textSecondary,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 Flexible(
//                   child: rentmebeachButton(
//                     text: confirmText,
//                     onPressed: isLoading ? null : onConfirm,
//                     isLoading: isLoading,
//                     backgroundColor: isDanger
//                         ? AppColors.redPrimary
//                         : AppColors.primaryColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
