import 'dart:io';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psiphon/vpn_psiphon.dart';
import 'package:soscuba/pages/home.dart';

import 'app/theme.dart';

void main() async {
  runApp(EasyDynamicThemeWidget(child: MyApp()));
  var status = await Psiphon.connect;
  // ignore: non_constant_identifier_names
  final PROXY = 'PROXY 127.0.0.1:${status.port};';
  HttpOverrides.global = MyProxyHttpOverride(PROXY);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic status = false;
  getData() async {
    status = await Psiphon.connect;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: lightThemeData,
        darkTheme: darkThemeData,
        themeMode: EasyDynamicTheme.of(context).themeMode,
        debugShowCheckedModeBanner: false,
        title: '#SOSCuba',
        home: status != false
            ? Home()
            : Scaffold(
                body: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image(
                          image: AssetImage('assets/logo.png'),
                          width: 100,
                          height: 100,
                        )),
                    SizedBox(height: 10),
                    CupertinoActivityIndicator(),
                    Text('Conectando...')
                  ],
                )),
              ));
  }
}

class MyProxyHttpOverride extends HttpOverrides {
  // ignore: non_constant_identifier_names
  final String PROXY;

  MyProxyHttpOverride(this.PROXY);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..findProxy = (uri) {
        return PROXY;
      }
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
