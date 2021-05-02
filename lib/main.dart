import 'package:flutter/material.dart';
import 'package:lallotales_character_creator/screens/character_sheet_screen.dart';
import 'package:lallotales_character_creator/screens/home_screen.dart';
import 'package:lallotales_character_creator/services/db_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBService.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'lallotales character creator',
        theme: ThemeData(
          primaryColor: const Color(0xff2E3645),
          accentColor: const Color(0xff415478),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 27, fontWeight: FontWeight.w400, color: Colors.white),
            headline2: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white),
            headline3: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
            bodyText1: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          CharacterSheetScreen.id: (context) => CharacterSheetScreen(),
        });
  }
}
