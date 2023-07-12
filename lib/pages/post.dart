import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soscuba/utils/enc.dart';

class PostPage extends StatefulWidget {
  final String id;
  final String author;
  final String authorImg;
  final String date;
  final String text;
  final String img;
  final String type;
  final String verified;
  final String likes;
  final String comments;
  final String shares;
  final String platform;
  PostPage({
    Key? key,
    required this.author,
    required this.authorImg,
    required this.date,
    required this.text,
    required this.img,
    required this.type,
    required this.verified,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.platform,
    required this.id,
  }) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Uint8List? bytes;
  String? platform;

  getdata(String id) {}

  // getVersion() async {
  //   if (Platform.isIOS) {
  //     platform = encryp('iPhone');
  //   } else {
  //     platform = encryp('Android');
  //   }
  //   print(platform);
  // }

  @override
  void initState() {
    platform = decryp(widget.platform);
    // getVersion();
    bytes = base64Decode(decryp(widget.img));
    getdata(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        title: Text(
          'Post',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                left: 15,
                right: 15,
                bottom: 5,
              ),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image(
                          width: 50,
                          height: 50,
                          image: NetworkImage(decryp(widget.authorImg)))),
                  SizedBox(width: 10),
                  Text(
                    decryp(
                      widget.author,
                    ),
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
              child: Text(
                decryp(widget.text),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(22)),
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    fit: BoxFit.cover,
                    image: MemoryImage(
                      bytes!,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.date + ' - ' + '#SOSCuba para ' + platform!,
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(icon: Icon(Icons.comment), onPressed: () {}),
                IconButton(icon: Icon(Icons.restore), onPressed: () {}),
                SizedBox(
                  width: 100,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              CupertinoIcons.heart,
                            ),
                            onPressed: () {}),
                        SizedBox(
                          width: 5,
                        ),
                        Text(widget.likes)
                      ],
                    ),
                  ),
                ),
                IconButton(icon: Icon(Icons.share), onPressed: () {})
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
