import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sary/Models/Item.dart';

class Items with ChangeNotifier {
  List<Item> _items = [];

  final String _dbKey = 'itemsList';
  Box<dynamic>? _db;
  List<Item> get items => _items;

  Items(Box<dynamic> db) {
    _db = db;
    List<String> stringList = _db!.containsKey(_dbKey) ? _db!.get(_dbKey) : [];
  }

  void addItem(Item item) {
    _items.add(item);
    _db!.put(_dbKey, _items);
    notifyListeners();
  }

  void deleteItem(Item item) {
    _items.remove(item);
    _db!.put(_dbKey, _items);
    notifyListeners();
  }

  Item? getItem(int id) {
    Item? item;
    _items.forEach((element) {
      element.id == id ? item = element : null;
    });
    return item;
  }
}
