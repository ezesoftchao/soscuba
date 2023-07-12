import 'package:flutter/material.dart';

void alert(BuildContext context, String msg) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: Text(msg),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
          ],
        );
      });
}
