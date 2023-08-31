import 'package:flutter/material.dart';
import 'package:planck/src/provider/db_provider.dart';

class IconCartController with ChangeNotifier {
  int _items = 0;

  IconCartController() {
    count();
  }

  count() async {
    _items = await DBProvider.db.countProducts();
    notifyListeners();
  }

  int get items => _items;

  set items(int current) {
    _items = current;
    notifyListeners();
  }
}
