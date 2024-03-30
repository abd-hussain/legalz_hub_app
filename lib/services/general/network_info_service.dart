import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:legalz_hub_app/utils/error/exceptions.dart';

class NetworkInfoService {
  StreamController<bool> networkStateStreamControler =
      StreamController.broadcast();
  StreamController<bool> firebaseInitNetworkStateStreamControler =
      StreamController.broadcast();
  Connectivity connectivity = Connectivity();

  Future<bool> isConnected() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        return true;
      default:
        throw ConnectionException(message: 'No Internet Connection');
    }
  }

  void initNetworkConnectionCheck() {
    connectivity.onConnectivityChanged.distinct((previous, next) {
      return previous == next;
    }).listen((event) {
      var isConnected = event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi;
      firebaseInitNetworkStateStreamControler.sink.add(isConnected);
      Future.delayed(const Duration(seconds: 1), () {
        networkStateStreamControler.sink.add(isConnected);
      });
    });
  }

  Future<bool> checkConnectivityonLunching() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        return await internetLookupCheck();
      default:
        return false;
    }
  }

  Future<bool> internetLookupCheck() async {
    try {
      final value = await lookup('google.com');

      if (value.isNotEmpty && value[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<InternetAddress>> lookup(String host) async {
    return InternetAddress.lookup(host);
  }
}
