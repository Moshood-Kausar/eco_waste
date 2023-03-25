import 'dart:io';
import 'package:eco_waste/utils/colors.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogCard extends StatefulWidget {
  final dynamic data;
  BlogCard({Key? key, this.data}) : super(key: key);

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
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
    widget.data.articles!.shuffle();

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

  final OpenWebsite inAppChrome = OpenWebsite();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: widget.data.articles!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(
                    url: Uri.parse("${widget.data.articles![index].url}")),
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
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.maingrey, width: 3.0),
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                //border:Border(Border))
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     blurRadius: 12.0,
                //     offset: const Offset(4.0, 5.0),
                //   ),
                // ],
                // border: Border.all(color: Colors.red),
              ),
              child: Column(
                children: [
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: FancyShimmerImage(
                      imageUrl: '${widget.data.articles![index].urlToImage}',
                      boxFit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.data.articles![index].title}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${widget.data.articles![index].description}",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        FittedBox(
                          child: Text.rich(
                            TextSpan(
                              text: 'By',
                              children: [
                                TextSpan(
                                  text:
                                      ' ${widget.data.articles![index].author} •',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' ${widget.data.articles![index].source!.name} ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.red,
                                  ),
                                ),
                                TextSpan(
                                    text:
                                        '• ${widget.data.articles![index].publishedAt}'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class OpenWebsite extends ChromeSafariBrowser {
  @override
  void onOpened() {
    debugPrint("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    debugPrint("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    debugPrint("ChromeSafari browser closed");
  }
}
