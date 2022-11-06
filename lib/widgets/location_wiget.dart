import 'package:flutter/material.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:location/location.dart';

class Locationwidget extends StatefulWidget {
  const Locationwidget({super.key});

  @override
  State<Locationwidget> createState() => _LocationwidgetState();
}

class _LocationwidgetState extends State<Locationwidget> {
  String? _previewImageurl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.white),
          ),
          height: 150,
          width: double.infinity,
          child: _previewImageurl == null
              ? Text(
                  'no locations added',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageurl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                final locdata = await Location().getLocation();
                final staticmapurl =
                    LocationHelper.generateLocationPreviewImage(
                        latitude: locdata.latitude,
                        longitude: locdata.longitude);
                setState(() {
                  _previewImageurl = staticmapurl;
                });
              },
              icon: Icon(Icons.location_on),
              label: Text('Current location'),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).accentColor)),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).accentColor),
              ),
              icon: Icon(Icons.map),
              label: Text('chosse from the map'),
            ),
          ],
        )
      ],
    );
  }
}
