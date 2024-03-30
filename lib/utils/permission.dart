import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<void> handlePermission(Permission permission) async {
    final status = await permission.request();
    log(status.toString());
  }
}
