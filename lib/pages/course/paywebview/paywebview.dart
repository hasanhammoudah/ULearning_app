import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/pages/common_widgets.dart';
import 'package:ulearning_app/pages/course/paywebview/bloc/payview_bloc.dart';
import 'package:ulearning_app/pages/course/paywebview/bloc/payview_event.dart';
import 'package:ulearning_app/pages/course/paywebview/bloc/payview_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayWebView extends StatefulWidget {
  const PayWebView({super.key});

  @override
  State<PayWebView> createState() => _PayWebViewState();
}

class _PayWebViewState extends State<PayWebView> {
  late final WebViewController webViewController;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    print('------------ my url is ${args['url']}');
    context.read<PayviewBloc>().add(TriggerWebView(args["url"]));
  }

  @override
  void dispose() {
    webViewController.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PayviewBloc, PayWebViewStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar("Payment page"),
          body: state.url == ""
              ? SizedBox(
                  height: 50.h,
                  width: 50.w,
                  child: const CircularProgressIndicator(),
                )
              : WebView(
                  initialUrl: state.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  javascriptChannels: {
                    JavascriptChannel(
                        name: 'Pay',
                        onMessageReceived: (JavascriptMessage message) {
                          print(message.message);
                          Navigator.of(context).pop(message.message);
                        }),
                  },
                  onWebViewCreated: (WebViewController w) {
                    webViewController = w;
                  }),
        );
      },
    );
  }
}
