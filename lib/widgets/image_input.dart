import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class Imageimput extends StatefulWidget {
  Function saveImagefunction;
  Imageimput(this.saveImagefunction);
  @override
  State<Imageimput> createState() => _ImageimputState();
}

class _ImageimputState extends State<Imageimput> {
  File? _imagestored;

  Future<void> _takepictrue() async {
    final picker = ImagePicker();
    final imagepicked = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );
    if (imagepicked == null) {
      return;
    }
    setState(() {
      _imagestored = File(imagepicked.path);
    });
    final appdir = await syspath.getApplicationDocumentsDirectory();

    final filename = path.basename(imagepicked.path);
    File tempfile = File(imagepicked.path);
    final String pathstring = '${appdir.path}/$filename';
    final savedImage = await tempfile.copy(pathstring);
    widget.saveImagefunction(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
                color: Theme.of(context).cardColor,
              ),
              height: 150,
              width: 200,
              child: _imagestored != null
                  ? Image.file(
                      _imagestored!,
                      fit: BoxFit.fill,
                    )
                  : Center(
                      child: Text('No image taken'),
                    ),
              alignment: Alignment.center,
            ),
          ),
          IconButton(
            iconSize: 50,
            color: Theme.of(context).accentColor,
            onPressed: () {
              _takepictrue();
            },
            icon: Icon(Icons.add_a_photo),
          ),
        ],
      ),
    );
  }
}
