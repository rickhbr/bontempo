import 'package:bontempo/components/layout/layout_webview.dart';
import 'package:bontempo/models/movie_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieModel? movie;

  const MovieDetailsPage({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'screen_name': "/movie-details/${movie!.id}",
        'screen_class': 'MovieDetailsPage',
      },
    );

    return LayoutWebview(
      title: "Dicas de Filmes",
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
          ..loadRequest(Uri.parse(movie!.url!)),
      ),
    );
  }
}
