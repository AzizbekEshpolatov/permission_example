import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  /// status -> agar foydalanuvchi permission bergan bolsa granted qaytaradi
  /// permission berilmagan bolsa denied qaytaradi

  static Future<bool> checkCameraPermission() async {
    var status = await Permission.camera.status;
    // statusi isGranted bolsa true qaytaradi aks xolda false;
    return status.isGranted;
  }

  /// Kamera ruxsatini so‘rashdan oldin tushuntirish kerakmi
  /// yoqligini tekshiradi.
  /// Agar foydalanuvchi ilgari ruxsatni rad etgan bo‘lsa va ilova yana ruxsat
  /// so‘rayotgan bo‘lsa, `true` qaytaradi. Aks holda, `false` qaytaradi.
  /// - Agar foydalanuvchi "Doimiy rad etish" (Don't ask again) tugmasini bossa,
  ///   bu metod har doim `false` qaytaradi.

  /*
  requestCameraPermission(
  onGranted: () {
    print("Kamera ruxsati berildi, endi uni ishlatish mumkin!");
  },
  onDenied: () {
    print("Foydalanuvchi ruxsatni rad etdi.");
  },
  onPermanentlyDenied: () {
    print("Ruxsat butunlay rad etildi, ilova sozlamalariga kiring!");
  },
);

   */

  static Future<bool> shouldShowCameraPermissionRationale() async {
    bool showRationale = await Permission.camera.shouldShowRequestRationale;
    if (showRationale) {
      debugPrint("Foydalanuvchiga tushuntirish berish tavsiya etiladi!");
    }
    return showRationale;
  }

  static Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.request();

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    return false;
  }

  static Future<bool> checkLocationPermission() async {
    var status = await Permission.location.status;
    return status.isGranted;
  }

  static Future<bool> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    return false;
  }
}
