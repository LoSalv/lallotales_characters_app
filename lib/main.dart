import 'package:flutter/material.dart';
import 'package:lallotales_character_creator/screens/character_sheet_screen.dart';
import 'package:lallotales_character_creator/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'lallotales character creator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          CharacterSheetScreen.id: (context) => CharacterSheetScreen(),
        });
  }
}
