import 'package:flutter/material.dart';

class MensajesPage extends StatefulWidget {
  MensajesPage({Key? key}) : super(key: key);

  @override
  _MensajesPageState createState() => _MensajesPageState();
}

class _MensajesPageState extends State<MensajesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        title: Text(
          'Mensajes',
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
