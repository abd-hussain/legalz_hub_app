import 'package:package_info_plus/package_info_plus.dart';

class Version {
  Future<String> getApplicationVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
