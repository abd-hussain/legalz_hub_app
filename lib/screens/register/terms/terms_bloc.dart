import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/services/filter_services.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class RegisterTermsBloc extends Bloc<FilterService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  late WebViewXController webviewController;

  UserType? userType;

  void handleReadingArguments({required Object? arguments}) {
    if (arguments != null) {
      final newArguments = arguments as Map<String, dynamic>;
      userType = newArguments[AppConstant.userType] as UserType?;
    }
  }

  @override
  onDispose() {
    webviewController.dispose();
  }
}
