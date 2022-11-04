import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/places.dart';

class Placesprovider with ChangeNotifier {
  List<Placesobject> _items = [];
  List<Placesobject> get items {
    return [..._items];
  }

  void addplace(String savetitle, File saveimage, Locations savedloc) {
    final newplace =
        Placesobject(DateTime.now().toString(), savetitle, saveimage, savedloc);
  }
}
