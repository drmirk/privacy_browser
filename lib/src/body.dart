import 'package:flutter/material.dart';

import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:validators/validators.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double progress = 0;
  var url = 'https://www.google.com';
  var urlTitle = 'Google';
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text('Google');

  InAppWebViewController webView;

  openUrl(value) {
    if (isURL(value)) {
      value = 'https://$value';
      webView.loadUrl(value);
    } else {
      value = "https://www.google.com/search?q=$value";
      webView.loadUrl(value);
    }
    _searchPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addressBar(),
      body: InAppWebView(
        initialUrl: url,
        initialHeaders: {},
        initialOptions: {
          "clearCache": true,
          "clearSessionCache": true,
        },
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
        },
        onLoadStart: (controller, url) {
          print("started $url");
          setState(() {
            url = url;
          });
        },
        onProgressChanged: (controller, progress) {
          setState(
            () {
              this.progress = progress / 100;
            },
          );
        },
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = new Icon(
          Icons.close,
          color: Colors.black,
        );
        _appBarTitle = TextField(
          decoration: InputDecoration(
            prefix: Text('https://'),
            isDense: true,
          ),
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.go,
          onSubmitted: openUrl,
        );
      } else {
        _searchIcon = Icon(
          Icons.search,
          color: Colors.black,
        );
        _appBarTitle = Text(urlTitle);
      }
    });
  }

  Widget addressBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: _appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: _searchIcon,
          color: Colors.black,
          onPressed: _searchPressed,
        ),
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
