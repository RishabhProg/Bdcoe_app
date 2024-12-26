import 'package:bdcoe/ui/achievement.dart';
import 'package:bdcoe/ui/domain.dart';
//import 'package:bdcoe/ui/home.dart';
import 'package:bdcoe/ui/scan.dart';
import 'package:bdcoe/ui/team.dart';
import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  final _items = <Widget>[
   const Icon(Icons.home, size: 30, color: Colors.black),
   const Icon(Icons.qr_code, size: 30, color: Colors.black),
   const Icon(Icons.photo_album, size: 30, color: Colors.black),
   const Icon(Icons.auto_awesome_rounded,size: 30, color: Colors.black),
   const Icon(Icons.person, size: 30, color: Colors.black),
  ];

  final _screen = [const Domain(), const scan(),const Achievement(),const Team()];
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
