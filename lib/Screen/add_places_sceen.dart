import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/places.dart';
import 'package:great_places/providers/places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_wiget.dart';
import 'package:provider/provider.dart';

class AddPlacesScreen extends StatefulWidget {
  static const route = '/addplaces';
  @override
  State<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  final _formkey = GlobalKey<FormState>();
  File? _savedImage;
  String? _savedtitle;
  Locations? savedloc = Locations(0, 0, '');
  void _savedImageFunction(File savedImage) {
    _savedImage = savedImage;
  }

  void _saveplace() {
    if (!_formkey.currentState!.validate() || _savedImage == null) {
      return;
    }
    _formkey.currentState!.save();
    Provider.of<Placesprovider>(context, listen: false).addplace(
      _savedtitle!,
      _savedImage!,
      savedloc!,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add a new place'),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              children: [
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 1, color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                label: Text('title'),
                              ),
                              onSaved: (newValue) {
                                _savedtitle = newValue;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'enter a va';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Imageimput(_savedImageFunction),
                SizedBox(
                  height: 20,
                ),
                Locationwidget(),
              ],
            ),
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.indigo[800],
                ),
                elevation: MaterialStateProperty.all(0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            onPressed: () {
              if (!_formkey.currentState!.validate()) {
                return;
              }
              print(Provider.of<Placesprovider>(context, listen: false).items);
              _saveplace();
            },
            icon: Icon(Icons.add),
            label: Text('add places'),
          )
        ],
      ),
    );
  }
}
