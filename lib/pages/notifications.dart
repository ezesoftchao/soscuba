import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        title: Text(
          'Notificaciones',
          style: TextStyle(
              fontWeight: FontWeight.w700,

              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.red),
        ),
      ),
      body: Container(),
    );
  }
}
