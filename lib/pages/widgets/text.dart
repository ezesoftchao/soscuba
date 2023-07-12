import 'package:flutter/material.dart';

class Textttt extends StatefulWidget {
  Textttt({Key? key}) : super(key: key);

  @override
  _TexttttState createState() => _TexttttState();
}

class _TexttttState extends State<Textttt>
    with AutomaticKeepAliveClientMixin<Textttt> {
  @override
  bool get wantKeepAlive => true;
  String text = 'Stop';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ElevatedButton(
      onPressed: () {
        text = 'play';
        // var status = Psiphon.stop();
        setState(() {});
      },
      child: Text(text),
    );
  }
}
