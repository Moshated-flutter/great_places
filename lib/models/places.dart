import 'dart:io';

import 'package:flutter/cupertino.dart';

class Locations {
  final double dx;
  final double dy;
  final String location;
  Locations(
    this.dx,
    this.dy,
    this.location,
  );
}

class Placesobject {
  final String id;
  final String title;
  final File image;
  final Locations loc;
  Placesobject(
    this.id,
    this.title,
    this.image,
    this.loc,
  );
}
