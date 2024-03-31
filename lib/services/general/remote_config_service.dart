import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:legalz_hub_app/services/general/network_info_service.dart';

import '../../../locator.dart';

class RemoteConfigService {
  FirebaseRemoteConfig? remoteConfig;
  Future<void> initInstance() async {
    var isConnected =
        await locator<NetworkInfoService>().checkConnectivityonLunching();
    if (isConnected) {
      remoteConfig = FirebaseRemoteConfig.instance;
    } else {
      locator<NetworkInfoService>()
          .networkStateStreamControler
          .stream
          .listen((event) {
        if (event) {
          remoteConfig = FirebaseRemoteConfig.instance;
          initialize();
        }
      });
    }
  }

  Future initialize() async {
    if (remoteConfig != null) {
      await remoteConfig!.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 30),
          minimumFetchInterval: const Duration(hours: 0),
        ),
      );
      await remoteConfig!.fetch();
      await remoteConfig!.activate();
    }
  }

  T? remoteConfigValue<T>(String configKey) {
    if (remoteConfig == null) {
      return null;
    }
    dynamic configValue;
    switch (T) {
      case double:
        configValue = remoteConfig?.getDouble(configKey) as double;
        break;
      case String:
        configValue = remoteConfig?.getString(configKey) as String;
        break;
      case int:
        configValue = remoteConfig?.getInt(configKey) as int;
        break;
      case bool:
        configValue = remoteConfig?.getBool(configKey) as bool;
        break;
    }

    return configValue;
  }
}
