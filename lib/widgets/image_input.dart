import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Imageimput extends StatefulWidget {
  Function saveImagefunction;
  Imageimput(this.saveImagefunction);
  @override
  State<Imageimput> createState() => _ImageimputState();
}

class _ImageimputState extends State<Imageimput> {
  File? _imagestored;

  Future<void> _takepictrue() async {
    final imagepicked = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );
    if (imagepicked == null) {
      return;
    }
    setState(() {
      _imagestored = File(imagepicked!.path);
    });
    final appdir = await getApplicationDocumentsDirectory();
    final filename = basename(imagepicked!.path);
    final savedImage =
        await imagepicked.saveTo('${appdir.path}/$filename.jpg') as File;
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
