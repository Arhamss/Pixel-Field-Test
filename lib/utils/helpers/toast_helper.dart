import 'package:pixelfield_test/exports.dart';
import 'package:toastification/toastification.dart';

class ToastHelper {
  static void showErrorToast(String? message) {
    toastification.show(
      description: Center(
        child: Text(
          message ?? 'Something went wrong. Please try again later.',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 4),
      alignment: Alignment.topCenter,
      showProgressBar: true,
      closeButton: const ToastCloseButton(
        showType: CloseButtonShowType.onHover,
      ),
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      progressBarTheme: const ProgressIndicatorThemeData(
        color: AppColors.error,
        linearMinHeight: 1,
      ),
    );
  }

  static void showSuccessToast(String message) {
    toastification.show(
      description: Center(
        child: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.topCenter,
      showProgressBar: true,
      closeButton: const ToastCloseButton(
        showType: CloseButtonShowType.onHover,
      ),
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );
  }

  static void showInfoToast(String message) {
    toastification.show(
      icon: const Icon(
        Icons.info_outline,
      ),
      description: Center(
        child: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      type: ToastificationType.info,
      autoCloseDuration: const Duration(seconds: 2),
      alignment: Alignment.topCenter,
      showProgressBar: true,
      closeButton: const ToastCloseButton(
        showType: CloseButtonShowType.onHover,
      ),
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );
  }
}
