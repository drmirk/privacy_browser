import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:validators/validators.dart';
import 'dart:io';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: addressBar(),
      body: browserWindow(),
    );
  }

  // use appBar as addressBar
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
        popupMenu(),
      ],
      flexibleSpace: LinearProgressIndicator(
        value: progress,
      ),
    );
  }

  // visual change of appBar to searchbar
  void _searchPressed() {
    setState(
      () {
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
            autofocus: true,
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
      },
    );
  }

  // open a new url
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

  Widget popupMenu() {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: Colors.black,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.arrow_forward),
              title: Text("Forward"),
              onTap: () {
                if (webView != null) {
                  webView.goForward();
                }
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text("Backward"),
              onTap: () {
                if (webView != null) {
                  webView.goBack();
                }
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.refresh),
              title: Text("Reload"),
              onTap: () {
                if (webView != null) {
                  webView.reload();
                }
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Exit"),
              onTap: () {
                exit(0);
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("About"),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: ListTile(
                          title: Text("Automatically Deletes Cache."),
                          subtitle: Text("Adblock coming soon!!!"),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Dismiss"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                }),
          )
        ];
      },
    );
  }

  // main widget to display website
  Widget browserWindow() {
    return InAppWebView(
      initialUrl: url,
      initialOptions: {
        "clearCache": true,
        "clearSessionCache": true,
      },
      onWebViewCreated: (InAppWebViewController controller) {
        webView = controller;
      },
      onLoadStart: (controller, url) {
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
    );
  }
}
