import 'package:flutter/material.dart';
import 'package:legalz_hub_app/screens/web_view/web_view_bloc.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final bloc = WebViewBloc();

  @override
  void didChangeDependencies() {
    bloc.extractArguments(context);
    bloc.userType = bloc.box.get(DatabaseFieldConstant.userType) == "customer"
        ? UserType.customer
        : UserType.attorney;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: bloc.pageTitle,
        userType: UserType.attorney,
      ),
      body: ValueListenableBuilder<LoadingStatus>(
          valueListenable: bloc.loadingStatus,
          builder: (context, loadingsnapshot, child) {
            if (loadingsnapshot == LoadingStatus.finish) {
              return WebViewAware(
                child: WebViewX(
                  key: const ValueKey('webviewx'),
                  ignoreAllGestures: false,
                  initialSourceType: SourceType.urlBypass,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  onWebViewCreated: (controller) async {
                    bloc.webviewController = controller;
                    bloc.webviewController!.loadContent(
                      bloc.webViewUrl,
                      sourceType: SourceType.urlBypass,
                    );
                  },
                ),
              );
            } else {
              return const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              );
            }
          }),
    );
  }
}
