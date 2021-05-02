import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lallotales_character_creator/services/character.dart';
import 'package:lallotales_character_creator/services/db_service.dart';
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
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          const SizedBox(
            height: 10,
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(8),
              1: FlexColumnWidth(0.2),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(children: [
                MyTextFieldWithLabel(
                  label: "name",
                  initialValue: character.name,
                  onChanged: (String value) {
                    character.name = value;
                    DBService.save();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                MyTextFieldWithLabel(
                  label: "exp",
                  inputType: TextInputType.number,
                  initialValue: character.exp,
                  onChanged: (String value) {
                    DBService.save();
                    return character.exp = value;
                  },
                  textAlign: TextAlign.center,
                ),
              ]),
              TableRow(children: [
                MyTextFieldWithLabel(
                  label: "race",
                  initialValue: character.race,
                  onChanged: (String value) {
                    DBService.save();
                    return character.race = value;
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                MyTextFieldWithLabel(
                  label: "wealth",
                  inputType: TextInputType.number,
                  initialValue: character.wealth,
                  onChanged: (String value) {
                    DBService.save();
                    return character.wealth = value;
                  },
                  textAlign: TextAlign.center,
                ),
              ]),
              TableRow(children: [
                MyTextFieldWithLabel(
                  label: "languages",
                  initialValue: character.languages,
                  onChanged: (String value) {
                    DBService.save();
                    return character.languages = value;
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                MyTextFieldWithLabel(
                  label: "bulk",
                  inputType: TextInputType.number,
                  initialValue: character.bulk,
                  onChanged: (String value) {
                    DBService.save();
                    return character.bulk = value;
                  },
                  textAlign: TextAlign.center,
                ),
              ]),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(0.3),
              2: FlexColumnWidth(3),
              3: FlexColumnWidth(0.3),
              4: FlexColumnWidth(3),
            },
            children: [
              TableRow(children: [
                MyTextFieldWithLabel(
                  label: "age",
                  initialValue: character.age,
                  inputType: TextInputType.number,
                  onChanged: (String value) {
                    DBService.save();
                    return character.age = value;
                  },
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 10,
                ),
                MyTextFieldWithLabel(
                  label: "gender",
                  textAlign: TextAlign.center,
                  initialValue: character.gender,
                  onChanged: (String value) {
                    DBService.save();
                    return character.gender = value;
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                MyTextFieldWithLabel(
                  label: "height",
                  textAlign: TextAlign.center,
                  inputType: TextInputType.number,
                  onChanged: (String value) {
                    DBService.save();
                    return character.height = value;
                  },
                  initialValue: character.height,
                ),
              ]),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(0.3),
              2: FlexColumnWidth(3),
              3: FlexColumnWidth(0.3),
              4: FlexColumnWidth(3),
            },
            children: [
              TableRow(children: [
                MyTextFieldWithLabel(
                  label: "hp",
                  inputType: TextInputType.number,
                  initialValue: character.hp,
                  onChanged: (String value) {
                    DBService.save();
                    return character.hp = value;
                  },
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 10),
                MyTextFieldWithLabel(
                  label: "max hp",
                  inputType: TextInputType.number,
                  initialValue: character.maxHp,
                  onChanged: (String value) {
                    DBService.save();
                    return character.maxHp = value;
                  },
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 10),
                MyTextFieldWithLabel(
                  label: "guard",
                  inputType: TextInputType.number,
                  initialValue: character.guard,
                  onChanged: (String value) {
                    DBService.save();
                    return character.guard = value;
                  },
                  textAlign: TextAlign.center,
                ),
              ]),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          MyTextFieldWithLabel(
            label: "link",
            initialValue: character.link,
            onChanged: (String value) {
              DBService.save();
              return character.link = value;
            },
          ),
          MyTextFieldWithLabel(
            label: "stance",
            initialValue: character.stance,
            onChanged: (String value) {
              DBService.save();
              return character.stance = value;
            },
          ),
          MyTextFieldWithLabel(
            label: "objective",
            initialValue: character.objective,
            onChanged: (String value) {
              DBService.save();
              return character.objective = value;
            },
          ),
        ],
      ),
    );
  }
}
