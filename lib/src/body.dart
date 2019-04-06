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

  openUrl(value) {
    _url = "https://$value";
    flutterWebViewPlugin.reloadUrl(_url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addressBar(),
      body: WebviewScaffold(
        url: _url,
      ),
    );
  }

  Widget addressBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextField(
        decoration: InputDecoration(
          prefixText: 'https://',
          hintText: "${_url.substring(8)}",
          isDense: true,
        ),
        keyboardType: TextInputType.url,
        onSubmitted: openUrl,
      ),
      actions: <Widget>[
        PopupMenuButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text("Forward"),
              ),
              PopupMenuItem(
                child: Text("Backward"),
              ),
            ];
          },
        ),
      ],
    );
  }
}
