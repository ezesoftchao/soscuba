import 'dart:async';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psiphon/vpn_psiphon.dart';
import 'package:soscuba/models/cards.dart';
import 'package:soscuba/pages/widgets/card.dart';
import 'package:soscuba/pages/widgets/new_post.dart';
import 'package:soscuba/pages/widgets/text.dart';
import 'package:soscuba/service/service.dart';
import 'package:soscuba/pages/widgets/account.dart';

class Tendences extends StatefulWidget {
  Tendences({Key? key}) : super(key: key);

  @override
  _TendencesState createState() => _TendencesState();
}

class _TendencesState extends State<Tendences>
    with AutomaticKeepAliveClientMixin<Tendences> {
  List<Post> posts = [];
  Service service = Service();

  Map<String, dynamic>? data;
  // List<dynamic> id = List();
  // List<dynamic> author = List();
  // List<dynamic> author_img = List();
  // List<dynamic> date = List();
  // List<dynamic> text = List();
  // List<dynamic> img = List();
  // List<dynamic> type = List();
  // List<dynamic> verified = List();
  // List<dynamic> likes = List();
  // List<dynamic> comments = List();
  // List<dynamic> shares = List();
  // List<dynamic> platform = List();
  bool status1 = false;
  bool loading = true;
  // ignore: unused_field
  String? _now;
  // ignore: unused_field
  Timer? _everySecond;

  getConnection() async {
    var status = await Psiphon.connectionState;
    var status2 = status.toString();
    if (status2 == "PsiphonConnectionState.connected") {
      status1 = true;
    } else {
      status1 = false;
    }
  }

  refreshData() async {
    // final posts = await service.getPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        actions: [
          EasyDynamicThemeBtn(),
          Textttt(),
          IconButton(
            icon: Icon(CupertinoIcons.person_alt_circle),
            iconSize: 40,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.red,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginpPage()));
            },
          ),
          // Account(),
        ],
        elevation: 1,
        title: Text(
          '#SOSCuba',
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.red),
        ),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            color: Colors.red,
            onRefresh: () async {
              loading = true;
              return refreshData();
            },
            child: ListView(
              children: [
                FutureBuilder(
                  future: Service().getPosts(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Post>> snapshot) {
                    List<Post> posts = snapshot.data!;
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: new Cards(
                                id: posts[index].id,
                                author: posts[index].author,
                                authorImg: posts[index].author_img,
                                date: posts[index].date,
                                text: posts[index].text,
                                img: posts[index].img,
                                type: posts[index].type,
                                verified: posts[index].verified,
                                likes: posts[index].likes,
                                comments: posts[index].comments,
                                shares: posts[index].shares,
                                platform: posts[index].platform,
                              ));
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       name[index],
                          //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                          //     ),
                          //   ],
                          // ),
                        },
                      );
                    } else {
                      return SizedBox(
                        height: size.height * 0.9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CupertinoActivityIndicator(),
                            Text('Cargando...')
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          NewPost()
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
