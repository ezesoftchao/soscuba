import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:psiphon/vpn_psiphon.dart';

class PsiphonView extends StatefulWidget {
  PsiphonView({Key key}) : super(key: key);

  @override
  _PsiphonViewState createState() => _PsiphonViewState();
}

class _PsiphonViewState extends State<PsiphonView> {
  var _text = "Here info about connection";
  var _status = "Here info about status connection";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(_text),
            SizedBox(height: 20),
            Text(_status),
            SizedBox(height: 50),
            FlatButton(
                onPressed: () async {
                  var status = await Psiphon.connect;

                  if (status.connected) {
                    HttpClient client = new HttpClient();
                    client.findProxy = (Uri uri) {
                      return 'PROXY 127.0.0.1:${status.port};';
                    };

                    var c = await client.getUrl(Uri.parse(
                        "http://flowmusic.nat.cu/api/getartists.php"));

                    final response = await c.close();

                    response.transform(utf8.decoder).listen((contents) {
                      _text = contents;
                      setState(() {});
                    });
                  }
                },
                child: Text("Connect with psiphon")),
            FlatButton(
                onPressed: () async {
                  // http.
                  HttpClient client = new HttpClient();
                  var c =
                      await client.getUrl(Uri.parse("http://flowmusic.nat.cu"));

                  final response = await c.close();

                  response.transform(utf8.decoder).listen((contents) {
                    _text = contents;
                    setState(() {});
                  });
                },
                child: Text("Connect without psiphon")),
            FlatButton(
              onPressed: () async {
                PsiphonConnectionState state = await Psiphon.connectionState;

                setState(() {
                  _status = state.toString();
                });
              },
              child: Text("get status"),
            ),
            FlatButton(
              onPressed: () async {
                Psiphon.stop();
              },
              child: Text("Stop"),
            ),
          ],
        ),
      ),
    );
  }
}
