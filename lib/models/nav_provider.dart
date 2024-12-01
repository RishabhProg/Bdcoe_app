import 'package:bdcoe/ui/achievement.dart';
import 'package:bdcoe/ui/event.dart';
import 'package:bdcoe/ui/home.dart';
import 'package:bdcoe/ui/scan.dart';
import 'package:bdcoe/ui/team.dart';
import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  final _items = <Widget>[
    Icon(Icons.home, size: 30, color: Colors.black),
    Icon(Icons.qr_code, size: 30, color: Colors.black),
    Icon(Icons.photo_album, size: 30, color: Colors.black),
    Icon(Icons.person, size: 30, color: Colors.black),
  ];

  final _screen = [Event(), Scan(), Achievement(), Team()];
  int _index = 0;

  List<Widget> get items => _items;
  List get screen => _screen;
  int get index => _index;
  void getIndex(int i) {
    _index = i;
    print(_index);
    notifyListeners();
  }
}
