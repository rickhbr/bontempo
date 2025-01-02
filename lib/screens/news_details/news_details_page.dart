import 'package:bontempo/components/layout/layout_webview.dart';
import 'package:bontempo/models/news_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsPage extends StatelessWidget {
  final NewsModel? news;

  const NewsDetailsPage({Key? key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': "/news-details/${news!.id}",
        'screen_class': 'NewsDetailsPage',
      },
    );

    return LayoutWebview(
      title: "Notícias",
      child: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {},
              onWebResourceError: (WebResourceError error) {},
            ),
          )
          ..loadRequest(Uri.parse(news!.url)),
      ),
    );
  }
}
