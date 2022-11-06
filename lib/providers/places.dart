import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/helpers/db.dart';
import 'package:great_places/models/places.dart';

class Placesprovider with ChangeNotifier {
  List<Placesobject> _items = [];
  List<Placesobject> get items {
    return [..._items];
  }

  void addplace(String savetitle, File saveimage, Locations savedloc) {
    final newplace =
        Placesobject(DateTime.now().toString(), savetitle, saveimage, savedloc);
    _items.add(newplace);
    notifyListeners();
    DbHelper.addinsert('user_places', {
      'id': newplace.id,
      'title': newplace.title,
      'image': newplace.image.path,
    });
  }

  Future<void> fetchdata() async {
    final datalist = await DbHelper.fetchdata('user_places');
    _items = datalist
        .map((e) => Placesobject(
            e['id'], e['title'], File(e['image']), Locations(0, 0, '')))
        .toList();
    notifyListeners();
  }
}
