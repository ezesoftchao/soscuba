import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soscuba/pages/mensajes.dart';
import 'package:soscuba/pages/notifications.dart';
import 'package:soscuba/pages/search.dart';
import 'package:soscuba/pages/tendences.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _courentTab = 0;
  final tabs = [
    Tendences(),
    SearchPage(),
    NotificationPage(),
    MensajesPage(),
  ];
  bool expanded = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _courentTab,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        elevation: 1,
        currentIndex: _courentTab,
        selectedItemColor: CupertinoColors.systemRed,
        unselectedItemColor: CupertinoColors.systemGrey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.house_fill,
              size: 24,
            ),
            // ignore: deprecated_member_use
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.search,
              size: 24,
            ),
            // ignore: deprecated_member_use
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.bell_fill,
              size: 24,
            ),
            // ignore: deprecated_member_use
            label: 'Notificaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.bubble_left_bubble_right,
              size: 24,
            ),
            // ignore: deprecated_member_use
            label: 'Mensajes',
          ),
        ],
        onTap: (index) {
          setState(() {
            _courentTab = index;
          });
        },
      ),
    );
  }
}
