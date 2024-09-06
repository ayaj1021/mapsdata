import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapsVenture extends StatefulWidget {
  const MapsVenture({super.key});
   static const routeName = '/mapsVenture';

  @override
  State<MapsVenture> createState() => _MapsVentureState();
}

class _MapsVentureState extends State<MapsVenture> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://mapsventures.com/'))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            const CircularProgressIndicator();
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
