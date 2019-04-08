import 'package:flutter/material.dart';

import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:validators/validators.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var url = 'https://www.google.com';

  InAppWebViewController webView;

  double progress = 0;

  openUrl(value) {
    if (isURL(value)) {
      webView.loadUrl(value);
    } else {
      value = "http://www.google.com/search?q=$value";
      webView.loadUrl(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addressBar(),
      body: InAppWebView(
        initialUrl: url,
        initialHeaders: {},
        initialOptions: {},
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
        },
        onLoadStart: (InAppWebViewController controller, String url) {
          print("started $url");
          setState(() {
            this.url = url;
          });
        },
        onProgressChanged: (InAppWebViewController controller, int progress) {
          setState(
            () {
              this.progress = progress / 100;
            },
          );
        },
      ),
    );
  }

  Widget addressBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextField(
        decoration: InputDecoration(
          prefixText: 'https://',
          hintText: "${url.substring(8)}",
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
                child: FlatButton(
                  child: Text("Forward"),
                  onPressed: () {
                    if (webView != null) {
                      webView.goForward();
                    }
                  },
                ),
              ),
              PopupMenuItem(
                child: FlatButton(
                  child: Text("Backward"),
                  onPressed: () {
                    if (webView != null) {
                      webView.goBack();
                    }
                  },
                ),
              ),
              PopupMenuItem(
                child: FlatButton(
                  child: Text("Reload"),
                  onPressed: () {
                    if (webView != null) {
                      webView.reload();
                    }
                  },
                ),
              ),
            ];
          },
        ),
      ],
    );
  }
}
