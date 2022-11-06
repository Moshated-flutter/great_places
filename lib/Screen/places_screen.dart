import 'package:flutter/material.dart';
import 'package:great_places/Screen/add_places_sceen.dart';
import 'package:great_places/Screen/details_places_sceen.dart';
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(
        future: Provider.of<Placesprovider>(context, listen: false).fetchdata(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<Placesprovider>(
                    builder: (context, value, child) => value.items.length <= 0
                        ? Center(
                            child: Text('No Place Added'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).cardColor,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(DetailsScreen.route);
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(value.items[index].image),
                                  ),
                                  title: Text(value.items[index].title),
                                ),
                              ),
                            ),
                            itemCount: value.items.length,
                          ),
                  ),
      ),
    );
  }
}
