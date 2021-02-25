import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lallotales_character_creator/services/character.dart';
import 'package:lallotales_character_creator/utilities/my_divider.dart';

Character character;

class InventoryTab extends StatefulWidget {
  InventoryTab({Character char}) {
    character = char;
  }

  @override
  _InventoryTabState createState() => _InventoryTabState();
}

class _InventoryTabState extends State<InventoryTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8),
      children: [
        Header("Addosso"),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListItem("Armatura in pelle"),
            ListItem("Fucile"),
          ],
        ),
        MyDivider(),
        Header("Zaino"),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListItem("Razioni da viaggio"),
            ListItem("Borraccia"),
            ListItem("Acciarino"),
          ],
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  Header(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(children: [
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 25),
          ),
        ),
        Icon(Icons.add),
      ]),
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Text(
        text,
        style: TextStyle(fontSize: 15),
      ),
      padding: EdgeInsets.fromLTRB(8, 10, 0, 10),
    );
  }
}
