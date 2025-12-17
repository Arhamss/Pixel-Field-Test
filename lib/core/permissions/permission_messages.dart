import 'dart:io';

import 'package:pixelfield_test/exports.dart';

class PermissionMessages {
  static String getCameraSettingsMessage(BuildContext context) {
    return Platform.isIOS
        ? 'Camera access is required. Please enable it in Settings > Privacy & Security > Camera.'
        : 'Camera access is required. Please enable it in Settings > Apps > kaprayy > Permissions.';
  }

  static String getNotificationSettingsMessage(BuildContext context) {
    return Platform.isIOS
        ? 'Notification access is required. Please enable it in Settings > Notifications.'
        : 'Notification access is required. Please enable it in Settings > Apps > kaprayy > Notifications.';
  }

  static String getMicrophoneSettingsMessage(BuildContext context) {
    return Platform.isIOS
        ? 'Storage permission is permanently denied. Please enable it in Settings.'
        : 'Storage access is required for this feature.';
  }

  static String getStoragePermissionDeniedMessage(BuildContext context) {
    return 'Photo library access is required for this feature.';
  }

  static String getStorageAccessRequiredMessage(BuildContext context) {
    return 'Microphone access is required. Please enable it in Settings > Privacy & Security > Microphone.';
  }

  static String getPhotoLibraryAccessRequiredMessage(BuildContext context) {
    return 'Microphone access is required. Please enable it in Settings > Apps > kaprayy > Permissions.';
  }

  static String getMicrophonePermissionDeniedMessage(BuildContext context) {
    return 'Microphone permission was denied.';
  }

  static String getAnotherPermissionRequestInProgressMessage(
    BuildContext context,
  ) {
    return 'Another permission request is already in progress';
  }

  static String getErrorOpeningAppSettingsMessage(
    BuildContext context,
    String error,
  ) {
    return 'Error opening app settings: $error';
  }

  static String getLocationSettingsMessage(BuildContext context) {
    return Platform.isIOS
        ? 'Location access is required. Please enable it in Settings > Privacy & Security > Location Services.'
        : 'Location access is required. Please enable it in Settings > Apps > kaprayy > Permissions.';
  }

  static String getLocationPermissionDeniedMessage(BuildContext context) {
    return 'Location permission was denied.';
  }
}
