import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DialogUtils {
  static void showPermissionDeniedDialog(
      BuildContext context, String permissionName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Permission Denied"),
          content: Text("Please allow access to $permissionName."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                openAppSettings(); // Open app settings to allow the user to grant permission
              },
              child: Text("Settings"),
            ),
          ],
        );
      },
    );
  }
}
