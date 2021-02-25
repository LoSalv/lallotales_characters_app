import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lallotales_character_creator/services/db_service.dart';
import 'package:lallotales_character_creator/utilities/my_divider.dart';
import 'package:lallotales_character_creator/utilities/my_text_field.dart';

Character character;

class AbilitiesTab extends StatefulWidget {
  AbilitiesTab({Character char}) {
    character = char;
  }
  @override
  _AbilitiesTabState createState() => _AbilitiesTabState();
}

class _AbilitiesTabState extends State<AbilitiesTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Table(
          columnWidths: {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(0.2),
            2: FlexColumnWidth(3),
            3: FlexColumnWidth(0.2),
            4: FlexColumnWidth(3),
          },
          children: [
            TableRow(children: [
              MyTextField(
                label: "Body",
                inputType: TextInputType.number,
                labelWeight: FontWeight.bold,
                center: true,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Reflex",
                inputType: TextInputType.number,
                labelWeight: FontWeight.bold,
                center: true,
                // initialValue: character.exp,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Mind",
                inputType: TextInputType.number,
                labelWeight: FontWeight.bold,
                center: true,
                // initialValue: character.exp,
              ),
            ]),
            TableRow(children: [
              MyTextField(
                label: "Athletics",
                inputType: TextInputType.number,
                center: true,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Acrobatics",
                inputType: TextInputType.number,
                center: true,
                // initialValue: character.exp,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Manipulation",
                inputType: TextInputType.number,
                center: true,
                // initialValue: character.exp,
              ),
            ]),
            TableRow(children: [
              MyTextField(
                label: "Fighting",
                inputType: TextInputType.number,
                center: true,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Shooting",
                inputType: TextInputType.number,
                center: true,
                // initialValue: character.exp,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Perception",
                inputType: TextInputType.number,
                center: true,
                // initialValue: character.exp,
              ),
            ]),
            TableRow(children: [
              MyTextField(
                label: "Intimidation",
                inputType: TextInputType.number,
                center: true,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Stealth",
                inputType: TextInputType.number,
                center: true,
                // initialValue: character.exp,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Knowledge",
                inputType: TextInputType.number,
                center: true,
                // initialValue: character.exp,
              ),
            ]),
          ],
        ),
        MyDivider(),
        MyTextField(
          label: "Magic",
          inputType: TextInputType.number,
          labelWeight: FontWeight.bold,
          center: true,
        ),
        Table(
          columnWidths: {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(0.2),
            2: FlexColumnWidth(3),
          },
          children: [
            TableRow(children: [
              MyTextField(
                label: "Alteration",
                inputType: TextInputType.number,
                center: true,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Movement",
                inputType: TextInputType.number,
                center: true,
                // initialValue: character.exp,
              ),
            ]),
            TableRow(children: [
              MyTextField(
                label: "Elemental",
                inputType: TextInputType.number,
                center: true,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Necromancy",
                inputType: TextInputType.number,
                center: true,
                // initialValue: character.exp,
              ),
            ]),
            TableRow(children: [
              MyTextField(
                label: "Influence",
                inputType: TextInputType.number,
                center: true,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Protection",
                inputType: TextInputType.number,
                center: true,
                // initialValue: character.exp,
              ),
            ]),
          ],
        ),
        MyDivider(),
        Header("Feats"),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListItem("Pallotole incantate"),
            ListItem("Lore Montagna"),
          ],
        ),
        MyDivider(),
        Header("Magical Capacities"),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListItem("Alarm"),
            ListItem("Homing Bullets"),
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
