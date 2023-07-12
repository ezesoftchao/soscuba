import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soscuba/env.dart';
import 'package:soscuba/utils/enc.dart';
import 'package:soscuba/utils/utils.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

// const _maxHeight = 500.0;
const _minHeight = 68.0;

class NewPost extends StatefulWidget {
  NewPost({Key? key}) : super(key: key);

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> with SingleTickerProviderStateMixin {
  bool loading = false;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  AnimationController? _controller;
  num curIndex = 0;
  String base64Image = '';
  TextEditingController postText = TextEditingController();
  String? platform;

  bool _expanded = false;
  double _currentHeight = _minHeight;
  Uint8List? bytes;

  getVersion() async {
    if (Platform.isIOS) {
      platform = encryp('iPhone');
    } else {
      platform = encryp('Android');
    }
    print(platform);
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      // reverseDuration: const Duration(milliseconds: 1000),
    );
    getVersion();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  _buttonImage(ImageSource source) async {
    try {
      _imageFile = await _picker.pickImage(
          source: source, imageQuality: 30, maxHeight: 480, maxWidth: 640);

      List<int> imageBytes = await _imageFile!.readAsBytes();
      base64Image = base64Encode(imageBytes);
      bytes = base64Decode(base64Image);
      print(base64Image.length);
      print(encryp(base64Image).length);

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  _sendPost() async {
    try {
      final http.Response response = await http.post(
        Uri.parse("${Env.URL_PREFIX}/add_post.php"),
        body: {
          "author": encryp('ezequiel_chaop'),
          "author_img":
              "NeGF0i+GBTeCGWSRa0ad6B87YQcwsIG9YF/BVB3nHn5blcIkH6ACZ5DffMJPxPtX3XFujQfw8DZUpEhRPbjQeqP5aIDT+svO0xf7I3JD9G536LA4LyTmE0lf50EFLvKFAuXoYJmysQSS4kNVV0F0LKTlgaVyPIalbxvvI3qWFx1nh0rSbTVLuer3ARUgc+ZYpAzbHISr03IOdATfZ/kq8looYBNDO636y9reqC26F9ZYLjmMHkpJ4K9v4puBP3rXRHJOItISHlJsNpzarX9W0152ja5TQTPBwCc8wZ3avWu2MtMqr3HmLCtcAT6S0/Zo/0l8pfn+A0LCRZY+01h3/AHKpjhEezmS6K1PFjRV5zc=",
          "text": encryp(postText.text),
          "img": encryp(base64Image),
          "type": 'basico',
          "verified": "true",
          "likes": "0",
          "comments": "0",
          "shares": "0",
          "platform": platform,
          // "send": "enviar",
        },
      );

      if (response.statusCode != 200) {
        alert(context, "Error de comunicándose con el servidor");
        loading = false;
        setState(() {});
        return;
      }
      _expanded = false;
      _controller?.reverse();

      postText.text = '';
      base64Image = '';
      setState(() {});

      Map<String, dynamic> decodeResp = json.decode(response.body);

      if (decodeResp['success']) {
        loading = false;
        setState(() {});
        Toast.show(
          "Tweet posteado con exito.",
          //  context,
          //     duration: Toast.LENGTH_LONG,
          //     gravity: Toast.BOTTOM,
          //     backgroundColor: Colors.green[400],
          // textColor: Colors.white
        );
        // Navigator.pushAndRemoveUntil(context, HomePage(), (e) => false);
        // Navigator.pushNamed(context, "home");
      } else {
        loading = false;
        setState(() {});
        alert(context, decodeResp.containsKey('error').toString());
        return;
      }
    } catch (e) {
      loading = false;
      setState(() {});
      alert(context, "Ha occurrido un error en la conexión con el servidor");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height * 0.7;
    return GestureDetector(
      onVerticalDragUpdate: _expanded
          ? (details) {
              setState(() {
                final newHeight = _currentHeight - details.delta.dy;
                _controller?.value = _currentHeight / size;
                _currentHeight = newHeight.clamp(_minHeight, size);
              });
            }
          : null,
      onVerticalDragEnd: _expanded
          ? (details) {
              if (_currentHeight < size / 2) {
                _controller?.reverse();
                _expanded = false;
              } else {
                _expanded = true;
                _controller?.forward(from: _currentHeight / size);
                _currentHeight = size;
              }
            }
          : null,
      child: AnimatedBuilder(
          animation: _controller!,
          builder: (context, snapshot) {
            final value =
                const ElasticInOutCurve(0.7).transform(_controller!.value);
            return Stack(
              children: [
                Positioned(
                  height: lerpDouble(123.5, _currentHeight, value),
                  // top: 10,
                  left: 0,
                  right: 0,
                  bottom: lerpDouble(0.0, 0.0, value),
                  child: _expanded
                      ? _buildContainerAll()
                      : buildContainerBar(size),
                ),
              ],
            );
          }),
    );
  }

  Widget _buildContainerAll() {
    final size = MediaQuery.of(context).size;
    // FocusScopeNode currentFocus = FocusScope.of(context);

    // if (!currentFocus.hasPrimaryFocus) {
    //   currentFocus.unfocus();
    // }
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 100.0,
                spreadRadius: 0.0,
                offset: Offset(0.5, 0.5))
          ],
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.all(8),
                  width: 40,
                  height: 40,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      print('hola');
                      _controller?.reverse();
                      _expanded = false;
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: loading
                      ? CupertinoActivityIndicator()
                      : ElevatedButton(
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(20.0),
                          // ),
                          onPressed: () {
                            if (postText.text == '' ||
                                postText.text.length <= 4 ||
                                base64Image == '') {
                              Toast.show(
                                "Revisa que hayas insertado una imagen y no dejes el campo de texto vacío",
                                // context,
                                // duration: Toast.LENGTH_LONG,
                                // gravity: Toast.BOTTOM,
                                // backgroundColor: Colors.red[400],
                                // textColor: Colors.white
                              );
                            } else {
                              loading = true;
                              setState(() {});
                              _sendPost();
                            }
                          },
                          child: Text('Postear',
                              style: TextStyle(color: Colors.white)),
                          // color: Colors.red,
                        ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image(
                          width: 50,
                          height: 50,
                          image: NetworkImage(decryp(
                              'NeGF0i+GBTeCGWSRa0ad6B87YQcwsIG9YF/BVB3nHn5blcIkH6ACZ5DffMJPxPtX3XFujQfw8DZUpEhRPbjQeqP5aIDT+svO0xf7I3JD9G536LA4LyTmE0lf50EFLvKFAuXoYJmysQSS4kNVV0F0LKTlgaVyPIalbxvvI3qWFx1nh0rSbTVLuer3ARUgc+ZYpAzbHISr03IOdATfZ/kq8looYBNDO636y9reqC26F9ZYLjmMHkpJ4K9v4puBP3rXRHJOItISHlJsNpzarX9W0152ja5TQTPBwCc8wZ3avWu2MtMqr3HmLCtcAT6S0/Zo/0l8pfn+A0LCRZY+01h3/AHKpjhEezmS6K1PFjRV5zc='))),
                    ),
                  ),
                  Container(
                    width: size.width * 0.75,
                    child: TextField(
                      controller: postText,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.red,
                      decoration: new InputDecoration(
                          fillColor: Colors.red,
                          border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 2)),
                          // hintText: 'Tell us about yourself',
                          // helperText: 'Keep it short, this is just a demo.',
                          labelText: 'Qué esta pasando?',
                          labelStyle: TextStyle(fontWeight: FontWeight.w600),
                          prefixText: ' ',
                          suffixStyle: const TextStyle(color: Colors.green)),
                      maxLines: 6,
                      maxLength: 256,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.language,
                  color: Colors.red[200],
                ),
                SizedBox(width: 5),
                Text(
                  'Cualquier persona puede responder',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.red[200]),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30, top: 10, bottom: 10),
              child: Divider(
                height: 2,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () async {
                      _buttonImage(ImageSource.gallery);
                    },
                    child: base64Image == ''
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 5),
                                  child: Icon(Icons.image_outlined,
                                      color: Colors.red)),
                              Text(
                                'Agregar Imagen',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  child: Stack(
                                    children: [
                                      Image.memory(
                                        bytes!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: () {
                                              base64Image = '';
                                              setState(() {});
                                            }),
                                      )
                                    ],
                                  ),
                                )),
                          )),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }

  Widget buildContainerBar(double size) {
    return ClipRRect(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
            onPressed: () {
              setState(() {
                _expanded = true;
                _currentHeight = size;
                _controller?.forward(from: 0.0);
              });
            },
            child: Icon(
              CupertinoIcons.add,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
