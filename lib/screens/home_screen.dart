import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lallotales_character_creator/screens/character_sheet_screen.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff2E3645),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, CharacterSheetScreen.id);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            ListItem(name: "Lyzz"),
            SizedBox(
              height: 5,
            ),
            ListItem(name: "Mech Chiaveinglese"),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatefulWidget {
  final String name;

  ListItem({@required this.name});

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 60,
      decoration: new BoxDecoration(
        color: Color(0xff415478),
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(7.0),
          topRight: const Radius.circular(7.0),
          bottomLeft: const Radius.circular(7.0),
          bottomRight: const Radius.circular(7.0),
        ),
      ),
      // color: Colors.blue[100],
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
