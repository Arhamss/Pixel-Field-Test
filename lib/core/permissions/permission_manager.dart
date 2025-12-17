import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Permission states
enum PermissionState {
  granted,
  denied,
  permanentlyDenied,
  restricted,
  limited,
  provisional,
  unknown,
}

/// Permission request result
class PermissionResult {
  const PermissionResult({
    required this.state,
    this.message,
    this.shouldShowRationale = false,
  });

  final PermissionState state;
  final String? message;
  final bool shouldShowRationale;

  bool get isGranted => state == PermissionState.granted;
  bool get isDenied => state == PermissionState.denied;
  bool get isPermanentlyDenied => state == PermissionState.permanentlyDenied;
}

class PermissionManager {
  static bool _isRequestingPermissions = false;
  static bool _isDialogShowing = false;

  /// Convert PermissionStatus to PermissionState
  static PermissionState _convertStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return PermissionState.granted;
      case PermissionStatus.denied:
        return PermissionState.denied;
      case PermissionStatus.permanentlyDenied:
        return PermissionState.permanentlyDenied;
      case PermissionStatus.restricted:
        return PermissionState.restricted;
      case PermissionStatus.limited:
        return PermissionState.limited;
      case PermissionStatus.provisional:
        return PermissionState.provisional;
    }
  }

  // ==================== Location Permission ====================

  /// Check if location services are enabled
  static Future<bool> isLocationServiceEnabled() async {
    try {
      return await Permission.location.serviceStatus.isEnabled;
    } catch (e) {
      debugPrint('Error checking location service status: $e');
      return false;
    }
  }

  /// Request location permission
  static Future<PermissionResult> requestLocationPermission() async {
    try {
      final isServiceEnabled = await isLocationServiceEnabled();
      if (!isServiceEnabled) {
        return const PermissionResult(
          state: PermissionState.denied,
          message: 'Location services are disabled. Please enable them in device settings.',
        );
      }

      final currentStatus = await Permission.location.status;
      if (currentStatus.isGranted) {
        return const PermissionResult(state: PermissionState.granted);
      }

      if (currentStatus.isPermanentlyDenied) {
        return const PermissionResult(
          state: PermissionState.permanentlyDenied,
          message: 'Location access is required. Please enable it in Settings.',
        );
      }

      final status = await Permission.location.request();
          return PermissionResult(
        state: _convertStatus(status),
        message: status.isPermanentlyDenied
            ? 'Location access is required. Please enable it in Settings.'
                : null,
        shouldShowRationale: status.isDenied,
      );
    } catch (e) {
      debugPrint('Error requesting location permission: $e');
      return const PermissionResult(
        state: PermissionState.unknown,
        message: 'An error occurred while requesting location permission.',
      );
    }
  }

  /// Request location permission with dialog
  static Future<bool> requestLocationWithDialog(BuildContext context) async {
    return requestPermissionWithDialog(
      context: context,
      permission: Permission.location,
      permissionName: 'Location',
      customPermanentlyDeniedMessage:
          'Location access is required. Please enable it in Settings to continue.',
    );
  }

  /// Open location settings
  static Future<bool> openLocationSettings() async {
    try {
      return await openAppSettings();
    } catch (e) {
      debugPrint('Error opening location settings: $e');
      return false;
    }
  }

  // ==================== Camera Permission ====================

  /// Request camera permission
  static Future<PermissionResult> requestCameraPermission() async {
    try {
      final status = await Permission.camera.request();
      return PermissionResult(
        state: _convertStatus(status),
        message: status.isPermanentlyDenied
            ? 'Camera access is required. Please enable it in Settings.'
            : null,
        shouldShowRationale: status.isDenied,
      );
    } catch (e) {
      debugPrint('Error requesting camera permission: $e');
      return const PermissionResult(
        state: PermissionState.unknown,
        message: 'An error occurred while requesting camera permission.',
      );
    }
  }

  /// Request camera permission with dialog
  static Future<bool> requestCameraWithDialog(BuildContext context) async {
    return requestPermissionWithDialog(
      context: context,
      permission: Permission.camera,
      permissionName: 'Camera',
      customPermanentlyDeniedMessage:
          'Camera access is required to take photos. Please enable it in Settings.',
    );
  }

  // ==================== Photos/Gallery Permission ====================

  /// Request photo library permission
  static Future<PermissionResult> requestPhotosPermission() async {
    try {
        final status = await Permission.photos.request();
      return PermissionResult(
        state: _convertStatus(status),
        message: status.isPermanentlyDenied
            ? 'Photo library access is required. Please enable it in Settings.'
            : null,
        shouldShowRationale: status.isDenied,
      );
    } catch (e) {
      debugPrint('Error requesting photos permission: $e');
      return const PermissionResult(
        state: PermissionState.unknown,
        message: 'An error occurred while requesting photo library permission.',
      );
    }
  }

  /// Request photo library permission with dialog
  static Future<bool> requestPhotosWithDialog(BuildContext context) async {
    return requestPermissionWithDialog(
      context: context,
      permission: Permission.photos,
      permissionName: 'Gallery',
      customPermanentlyDeniedMessage:
          'Gallery access is required to select photos. Please enable it in Settings.',
    );
  }

  // ==================== Generic Permission Methods ====================

  /// Generic permission request
  static Future<PermissionResult> requestPermission(
    Permission permission,
  ) async {
    try {
      final status = await permission.request();
      return PermissionResult(
        state: _convertStatus(status),
        message: status.isPermanentlyDenied
            ? 'Permission is required. Please enable it in Settings.'
            : null,
        shouldShowRationale: status.isDenied,
      );
    } catch (e) {
      debugPrint('Error requesting permission: $e');
      return const PermissionResult(
        state: PermissionState.unknown,
        message: 'An error occurred while requesting permission.',
      );
    }
  }

  /// Request permission with automatic dialog handling
  static Future<bool> requestPermissionWithDialog({
    required BuildContext context,
    required Permission permission,
    required String permissionName,
    String? customDeniedMessage,
    String? customPermanentlyDeniedMessage,
  }) async {
    try {
      final result = await requestPermission(permission);

      if (result.isGranted) {
        return true;
      }

      if (result.isPermanentlyDenied) {
        await _showPermissionSettingsDialog(
          context: context,
          permissionName: permissionName,
          message: customPermanentlyDeniedMessage ??
              '$permissionName access is required. Please enable it in Settings to continue.',
        );
        return false;
      }

      return false;
    } catch (e) {
      debugPrint('Error requesting permission with dialog: $e');
      return false;
    }
  }

  /// Check if a permission is granted
  static Future<bool> isGranted(Permission permission) async {
    try {
      final status = await permission.status;
      return status.isGranted;
    } catch (e) {
      debugPrint('Error checking permission status: $e');
      return false;
    }
  }

  /// Check if a permission is permanently denied
  static Future<bool> isPermanentlyDenied(Permission permission) async {
    try {
      final status = await permission.status;
      return status.isPermanentlyDenied;
    } catch (e) {
      debugPrint('Error checking permission status: $e');
      return false;
    }
  }

  /// Request multiple permissions at once
  static Future<Map<Permission, PermissionResult>> requestMultiplePermissions(
    List<Permission> permissions,
  ) async {
    if (_isRequestingPermissions) {
      debugPrint('Another permission request is already in progress');
      return {};
    }

    try {
      _isRequestingPermissions = true;
      final statusMap = await permissions.request();

      final resultMap = <Permission, PermissionResult>{};
      for (final entry in statusMap.entries) {
        resultMap[entry.key] = PermissionResult(
          state: _convertStatus(entry.value),
          message: entry.value.isPermanentlyDenied
              ? 'Permission is required. Please enable it in Settings.'
              : null,
          shouldShowRationale: entry.value.isDenied,
        );
      }

      return resultMap;
    } finally {
      _isRequestingPermissions = false;
    }
  }

  /// Check if all permissions are granted
  static Future<bool> arePermissionsGranted(
    List<Permission> permissions,
  ) async {
    for (final permission in permissions) {
      if (!(await isGranted(permission))) {
        return false;
      }
    }
    return true;
  }

  /// Open app settings
  static Future<bool> openAppSettingsPage() async {
    try {
        return await openAppSettings();
    } catch (e) {
      debugPrint('Error opening app settings: $e');
      return false;
    }
  }

  // ==================== Internal Dialog ====================

  /// Show settings dialog for permanently denied permissions
  static Future<void> _showPermissionSettingsDialog({
    required BuildContext context,
    required String permissionName,
    required String message,
  }) async {
    if (_isDialogShowing) return;

    _isDialogShowing = true;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => _PermissionSettingsDialog(
        title: '$permissionName Permission Required',
        message: message,
      ),
    );

    _isDialogShowing = false;
  }
}

/// Internal permission settings dialog widget
class _PermissionSettingsDialog extends StatelessWidget {
  const _PermissionSettingsDialog({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.settings_outlined,
              size: 48,
              color: Color(0xFF1E1E1E),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1E1E),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1E1E1E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: const BorderSide(color: Color(0xFF1E1E1E)),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await PermissionManager.openAppSettingsPage();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF1E1E1E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
