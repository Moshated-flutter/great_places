import 'package:flutter/material.dart';
import 'package:great_places/Screen/add_places_sceen.dart';
import 'package:great_places/providers/places.dart';
import 'package:provider/provider.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Places'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlacesScreen.route);
              },
              icon: Icon(Icons.add_location_alt_outlined),
            )
          ],
        ),
        body: Consumer<Placesprovider>(
          builder: (context, value, child) => value.items.length <= 0
              ? Center(
                  child: Text('No Place Added'),
                )
              : ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(value.items[index].image),
                    ),
                    title: Text(value.items[index].title),
                  ),
                  itemCount: value.items.length,
                ),
        ));
  }
}
