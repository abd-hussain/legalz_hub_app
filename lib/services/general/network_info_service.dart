import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:legalz_hub_app/utils/error/exceptions.dart';

class NetworkInfoService {
  StreamController<bool> networkStateStreamControler =
      StreamController.broadcast();
  Connectivity connectivity = Connectivity();

  Future<bool> isConnected() async {
    final ConnectivityResult result = await connectivity.checkConnectivity();
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        networkStateStreamControler.sink.add(true);
        return true;
      default:
        networkStateStreamControler.sink.add(false);
        throw ConnectionException(message: 'No Internet Connection');
    }
  }

  void initNetworkConnectionCheck() {
    connectivity.onConnectivityChanged.distinct((previous, next) {
      return previous == next;
    }).listen((event) {
      final isConnected = event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi;
      networkStateStreamControler.sink.add(isConnected);
    });
  }

  Future<bool> checkConnectivityonLunching() async {
    final ConnectivityResult result = await connectivity.checkConnectivity();
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        networkStateStreamControler.sink.add(true);
        return _internetLookupCheck();
      default:
        networkStateStreamControler.sink.add(false);
        return false;
    }
  }

  Future<bool> _internetLookupCheck() async {
    try {
      final value = await _lookup('google.com');

      if (value.isNotEmpty && value[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<InternetAddress>> _lookup(String host) async {
    return InternetAddress.lookup(host);
  }
}
