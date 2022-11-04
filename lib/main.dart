import 'package:flutter/material.dart';
import 'package:great_places/Screen/add_places_sceen.dart';
import 'package:great_places/Screen/details_places_sceen.dart';
import 'package:great_places/Screen/places_screen.dart';
import 'package:great_places/providers/places.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Placesprovider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Color.fromARGB(255, 45, 119, 144),
          cardColor: Colors.grey[200],
          backgroundColor: Colors.grey[400],
        ),
        home: PlacesScreen(),
        routes: {
          DetailsScreen.route: (context) => DetailsScreen(),
          AddPlacesScreen.route: (context) => AddPlacesScreen(),
        },
      ),
    );
  }
}
