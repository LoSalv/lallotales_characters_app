import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lallotales_character_creator/screens/character_sheet_screen.dart';
import 'package:lallotales_character_creator/services/character.dart';
import 'package:lallotales_character_creator/services/db_service.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).accentColor,
          ],
        )),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            title: Text(
              "characters",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            onPressed: () {
              characterList.add(Character());
              DBService.save();
              Navigator.pushNamed(context, CharacterSheetScreen.id,
                      arguments: characterList.length - 1)
                  .then((value) => setState(() {}));
            },
            backgroundColor: Colors.transparent.withOpacity(0.2),
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: characterList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListItem(
                characterIndex: index,
                parent: this,
              );
            },
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final int characterIndex;
  final State parent;

  const ListItem({@required this.characterIndex, @required this.parent});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    Character characterToRemove;
    final Character character = characterList[characterIndex];

    Widget getAlertBuilder(BuildContext context) {
      return AlertDialog(
        title: const Text('Are you sure you want to remove the character? '),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              characterList.remove(characterToRemove);
              DBService.save();
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 60,
      decoration: BoxDecoration(
        // color: themeData.accentColor,
        color: Colors.transparent.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(7.0),
          topRight: Radius.circular(7.0),
          bottomLeft: Radius.circular(7.0),
          bottomRight: Radius.circular(7.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    CharacterSheetScreen.id,
                    arguments: characterIndex,
                  ).then((_) {
                    // ignore: invalid_use_of_protected_member
                    parent.setState(() {});
                  });
                },
                child: Text(
                  character.name,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                characterToRemove = character;
                showDialog(context: context, builder: getAlertBuilder)
                    .then((_) {
                  // ignore: invalid_use_of_protected_member
                  parent.setState(() {});
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "x",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
