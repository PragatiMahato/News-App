import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../models/news_models.dart';


class WebViewScreen extends StatefulWidget {
  final ArticleModel articlemodal;
  const WebViewScreen({super.key, required this.articlemodal});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  


  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.loadRequest(Uri.parse(widget.articlemodal.url.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 248, 238, 226),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
