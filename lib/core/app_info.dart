// This file fetches app version and metadata. 
// Can be extended for additional app-related info
import 'package:package_info_plus/package_info_plus.dart';

//==================[GET APP VERSION && BUILD]==================
class AppSetup{
  static String appVersion = '';
  static String buildNumber = '';

  static Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersion = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
  }
}