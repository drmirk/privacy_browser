import 'package:flutter/material.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart' as web;
import 'package:webview_flutter/webview_flutter.dart' as web;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _url = "https://www.gmail.com";
  TextEditingController textController;

  web.WebViewController _controller;

  reloadPage(value) {
    _url = "https://$value";
    setState(
      () {
        _controller.loadUrl(_url);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onSubmitted: reloadPage,
          autocorrect: false,
          keyboardType: TextInputType.url,
          controller: textController,
          decoration: InputDecoration(
            prefixText: 'https://',
          ),
        ),
      ),
      body: web.WebView(
        initialUrl: _url,
        javascriptMode: web.JavascriptMode.unrestricted,
        onWebViewCreated: (web.WebViewController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
