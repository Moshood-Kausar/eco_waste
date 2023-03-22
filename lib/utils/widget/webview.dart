import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViews extends StatefulWidget {
  final String title, link;
  const WebViews({Key? key, required this.title, required this.link})
      : super(key: key);

  @override
  State<WebViews> createState() => _WebViewsState();
}

class _WebViewsState extends State<WebViews> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? _webViewController;
  double progress = 0;
  dynamic urls = '';
  PullToRefreshController? pullToRefreshController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      javaScriptEnabled: true,
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      initialScale: 100,
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true),
  );
  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: Colors.blue),
      onRefresh: () async {
        if (Platform.isAndroid) {
          _webViewController!.reload();
        } else if (Platform.isIOS) {
          _webViewController?.loadUrl(
            urlRequest: URLRequest(url: await _webViewController!.getUrl()),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: const Color(0xffF4F4F4),
        foregroundColor: const Color(0xff161616),
        title: Text(widget.title),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                if (_webViewController != null) {
                  _webViewController!.reload();
                }
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            progress < 1.0
                ? LinearProgressIndicator(
                    value: progress,
                    minHeight: 2.0,
                    backgroundColor: const Color(0xffD6D6D6),
                    valueColor:
                        //const AlwaysStoppedAnimation<Color>(Colors.blue),
                        const AlwaysStoppedAnimation<Color>(Color(0xff161616)),
                  )
                : Container(),
            Expanded(
              child: InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: Uri.parse(widget.link)),
                initialOptions: options,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    urls = url;
                  });
                },
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                onLoadStop: (controller, url) {
                  pullToRefreshController!.endRefreshing();
                },
                onLoadError: (controller, url, code, message) {
                  pullToRefreshController!.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController!.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
                onConsoleMessage: (controller, consoleMessage) {
                  debugPrint('$consoleMessage');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
