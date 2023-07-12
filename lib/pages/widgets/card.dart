import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soscuba/pages/post.dart';
import 'package:soscuba/utils/enc.dart';

const _minHeight = 68.0;

date(String date) {
  var tempDate = DateTime.parse(date);

  var now = DateTime.now();

  var dated = now.difference(tempDate).inDays.toString();
  return dated;
}

class Cards extends StatefulWidget {
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

  Cards({
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
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(decryp(widget.img));
    return buildCard(
        bytes,
        widget.id,
        widget.author,
        widget.authorImg,
        widget.text,
        widget.img,
        widget.type,
        widget.verified,
        widget.likes,
        widget.comments,
        widget.shares,
        widget.platform);
  }

  Widget _buildContainerAll() {
    return Container();
  }

  Widget buildCard(
    Uint8List bytes,
    String id,
    String author,
    String author_img,
    String text,
    String img,
    String type,
    String verified,
    String likes,
    String comments,
    String shares,
    String platform,
  ) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostPage(
                          id: id,
                          author: author,
                          authorImg: author_img,
                          date: widget.date,
                          text: text,
                          img: img,
                          type: type,
                          verified: verified,
                          likes: likes,
                          comments: comments,
                          shares: shares,
                          platform: platform,
                        )));
          },
          child: Column(
            children: [
              Container(
                width: double.infinity,
                // height: 85,
                decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[900]
                        : Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: Image(
                                  width: 22,
                                  height: 22,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(decryp(widget.authorImg)),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              decryp(widget.author),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Container(
                              width: 15,
                              height: 15,
                              child: Image.network(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Twitter_Verified_Badge.svg/480px-Twitter_Verified_Badge.svg.png'),
                            ),
                            Spacer(),
                            Text(
                              date(widget.date) == '0'
                                  ? 'Hoy'
                                  : date(widget.date) == '1'
                                      ? 'Ayer'
                                      : int.parse(date(widget.date)) >= 30 &&
                                              int.parse(date(widget.date)) <= 60
                                          ? 'Hace un mes'
                                          : int.parse(date(widget.date)) > 60
                                              ? 'Hace unos meses'
                                              : date(widget.date) + ' días',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: [
                            Text(
                              decryp(widget.text),
                              style: TextStyle(
                                  fontSize: 18,
                                  // color: Colors.white,
                                  fontWeight: FontWeight.w300),
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                      // topRight: Radius.circular(15),
                      // topLeft: Radius.circular(15)),
                      child: Image(
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        image: MemoryImage(
                          bytes,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 160.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        color: Colors.grey[400]?.withOpacity(0.7),
                      ),
                      width: double.infinity,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              icon: Icon(Icons.comment), onPressed: () {}),
                          IconButton(
                              icon: Icon(Icons.restore), onPressed: () {}),
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
