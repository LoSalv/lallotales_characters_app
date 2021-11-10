import 'package:flutter/material.dart';
import 'package:lallotales_character_creator/screens/character_sheet_screen.dart';
import 'package:lallotales_character_creator/screens/home_screen.dart';
import 'package:lallotales_character_creator/services/db_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBService.load();
  // Directory('lallotales').create()
  //     // The created directory is returned as a Future.
  //     .then((Directory directory) {
  //   print(directory.path);
  // });

  runApp(MyApp());
}

const List<List<Color>> colors = [
  [
    Color(0xff2E3645),
    Color.fromARGB(255, 143, 93, 166),
    Color.fromARGB(255, 239, 106, 187)
  ],
  [
    Color(0xff2A3950),
    Color(0xff355C7D),
    Color(0xff725A7A),
    Color(0xffC56D86),
    Color(0xffFF7582),
  ],
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'lallotales character creator',
        theme: ThemeData(
          primaryColor: colors[1][0],
          // primaryColor: const Color.fromRGBO(63, 81, 181, 1),
          // accentColor: const Color(0xff415478),
          accentColor: colors[1][4],
          disabledColor: colors[1][2],
          // accentColor: const Color.fromARGB(220, 34, 204, 227),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          splashColor: Colors.transparent,
          unselectedWidgetColor: colors[1][2],
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
