import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _url = 'https://www.google.com';
  var flutterWebViewPlugin = new FlutterWebviewPlugin();

//  var _url2 = 'https://www.youtube.com';

  newUrl(value) {
    _url = "https://$value";
    flutterWebViewPlugin.reloadUrl(_url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(prefixText: 'https://'),
          onSubmitted: newUrl,
        ),
      ),
      body: WebviewScaffold(
        url: _url,
      ),
    );
  }
}
