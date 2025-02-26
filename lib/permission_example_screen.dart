import 'package:flutter/material.dart';
import 'package:flutter_permission_practice/utils/permission_helper.dart';

class PermissionExampleScreen extends StatefulWidget {
  const PermissionExampleScreen({super.key});

  @override
  State<PermissionExampleScreen> createState() =>
      _PermissionExampleScreenState();
}

class _PermissionExampleScreenState extends State<PermissionExampleScreen> {
  bool _hasCameraPermission = false;
  bool _hasLocationPermission = false;

  Future<void> _checkPermission(
    Future<bool> Function() checkPermission,
    Function(bool) updateState,
  ) async {
    bool granted = await checkPermission();
    setState(() => updateState(granted));
  }

  Future<void> _requestPermission(
    Future<bool> Function() shouldShowRationale,
    Future<bool> Function() requestPermission,
    Function(bool) updateState,
    String permissionName,
  ) async {
    bool showRationale = await shouldShowRationale();

    if (showRationale) {
      _showRationaleDialog(permissionName, () async {
        Navigator.pop(context);
        bool granted = await requestPermission();
        setState(() => updateState(granted));
      });
    } else {
      bool granted = await requestPermission();
      setState(() => updateState(granted));
    }
  }

  void _showRationaleDialog(String permissionName, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("$permissionName ruxsati kerak"),
            content: Text(
              "Ilova $permissionName dan foydalanish uchun ruxsat talab qiladi.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Bekor qilish"),
              ),
              TextButton(onPressed: onConfirm, child: Text("Ruxsat berish")),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Permission Example")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _hasCameraPermission
                  ? "✅ Kamera ruxsati mavjud"
                  : "❌ Kamera ruxsati yo‘q",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed:
                  () => _checkPermission(
                    PermissionHelper.checkCameraPermission,
                    (bool granted) => _hasCameraPermission = granted,
                  ),
              child: Text("Kamera ruxsatini tekshirish"),
            ),
            ElevatedButton(
              onPressed:
                  () => _requestPermission(
                    PermissionHelper.shouldShowCameraPermissionRationale,
                    PermissionHelper.requestCameraPermission,
                    (bool granted) => _hasCameraPermission = granted,
                    "Kamera",
                  ),
              child: Text("Kamera ruxsatini so‘rash"),
            ),
            SizedBox(height: 20),
            Text(
              _hasLocationPermission
                  ? "✅ Location ruxsati mavjud"
                  : "❌ Location ruxsati yo‘q",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed:
                  () => _checkPermission(
                    PermissionHelper.checkLocationPermission,
                    (bool granted) => _hasLocationPermission = granted,
                  ),
              child: Text("Location ruxsatini tekshirish"),
            ),

            ElevatedButton(
              onPressed:
                  () => _requestPermission(
                    PermissionHelper.shouldShowCameraPermissionRationale,
                    PermissionHelper.requestLocationPermission,
                    (bool granted) => _hasLocationPermission = granted,
                    "Location",
                  ),
              child: Text("Location ruxsatini so‘rash"),
            ),
          ],
        ),
      ),
    );
  }
}
