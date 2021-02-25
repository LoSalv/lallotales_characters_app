import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lallotales_character_creator/services/db_service.dart';
import 'package:lallotales_character_creator/utilities/my_divider.dart';
import 'package:lallotales_character_creator/utilities/my_text_field.dart';

Character character;

class GeneralInfoTab extends StatefulWidget {
  GeneralInfoTab({Character char}) {
    character = char;
  }
  @override
  _GeneralInfoTabState createState() => _GeneralInfoTabState();
}

class _GeneralInfoTabState extends State<GeneralInfoTab> {
  @override
  Widget build(BuildContext context) {
    // return Icon(Icons.face);
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Table(
          columnWidths: {
            0: FlexColumnWidth(8),
            1: FlexColumnWidth(0.5),
            2: FlexColumnWidth(3),
          },
          children: [
            TableRow(children: [
              MyTextField(
                label: "Name",
                initialValue: character.name,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Exp",
                inputType: TextInputType.number,
                // initialValue: character.exp,
              ),
            ]),
            TableRow(children: [
              MyTextField(
                label: "Race",
                initialValue: character.race,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Alignment",
                // initialValue: character.exp,
              ),
            ]),
            TableRow(children: [
              MyTextField(
                label: "Hobby",
                // initialValue: character.race,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Wealth",
                inputType: TextInputType.number,
                // initialValue: character.exp,
              ),
            ]),
            TableRow(children: [
              MyTextField(
                label: "Languages",
                // initialValue: character.race,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Bulk",
                inputType: TextInputType.number,
                // initialValue: character.exp,
              ),
            ]),
          ],
        ),
        Table(
          columnWidths: {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(0.5),
            2: FlexColumnWidth(3),
            3: FlexColumnWidth(0.5),
            4: FlexColumnWidth(3),
          },
          children: [
            TableRow(children: [
              MyTextField(
                label: "Age",
                initialValue: character.name,
                inputType: TextInputType.number,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Gender",
                // initialValue: character.exp,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Height",
                inputType: TextInputType.number,
                // initialValue: character.exp,
              ),
            ]),
          ],
        ),
        MyDivider(),
        Table(
          columnWidths: {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(0.5),
            2: FlexColumnWidth(3),
            3: FlexColumnWidth(0.5),
            4: FlexColumnWidth(3),
          },
          children: [
            TableRow(children: [
              MyTextField(
                label: "HP ",
                inputType: TextInputType.number,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Max HP",
                inputType: TextInputType.number,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "AC",
                inputType: TextInputType.number,
              ),
            ]),
            TableRow(children: [
              MyTextField(
                label: "Stability",
                inputType: TextInputType.number,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Max Stab.",
                inputType: TextInputType.number,
              ),
              SizedBox(
                width: 10,
              ),
              MyTextField(
                label: "Speed",
                inputType: TextInputType.number,
              ),
            ]),
          ],
        ),
        MyDivider(),
        MyTextField(label: "Link"),
        MyTextField(label: "Stance"),
        MyTextField(label: "Objective"),
      ],
    );
  }
}
