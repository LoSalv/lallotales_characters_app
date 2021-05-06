import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lallotales_character_creator/services/character.dart';
import 'package:lallotales_character_creator/services/db_service.dart';
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
    final List<Widget> _feats = character.feats
        .map<Widget>(
          (e) => MyTile(
            body: e.description,
            feat: e,
            parent: this,
            title: e.name,
          ),
        )
        .toList();

    final List<Widget> _magicalSkills = character.magicalSkills
        .map<Widget>(
          (e) => MyTile(
            body: e.description,
            feat: e,
            parent: this,
            title: e.name,
            isMagicalSkill: true,
          ),
        )
        .toList();

    final List<TableRow> attributeRows = [];
    TableRow row;

    for (int i = 0; i < character.attributes.length; i += 3) {
      row = TableRow(
        children: [
          AttributeField(
            attribute: character.attributes[i],
            parent: this,
          ),
          const SizedBox(
            width: 10,
          ),
          AttributeField(
            attribute: character.attributes[i + 1],
            parent: this,
          ),
          const SizedBox(
            width: 10,
          ),
          AttributeField(
            attribute: character.attributes[i + 2],
            parent: this,
          ),
        ],
      );
      attributeRows.add(row);
    }
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
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(0.2),
              2: FlexColumnWidth(3),
              3: FlexColumnWidth(0.2),
              4: FlexColumnWidth(3),
            },
            children: attributeRows,
          ),
          const SizedBox(
            height: 30,
          ),
          Header(text: "feats", parent: this),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: _feats,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Header(
            text: "magical skills",
            parent: this,
            magicalSkills: true,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: _magicalSkills,
            ),
          ),
        ],
      ),
    );
  }
}

class AttributeField extends StatelessWidget {
  final Attribute attribute;
  final State parent;

  const AttributeField({this.attribute, this.parent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
      child: GestureDetector(
        onDoubleTap: () {
          final int roll = Random().nextInt(12) + 1 + attribute.value;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              '${attribute.name} roll (1d12 + ${attribute.value}): $roll',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            duration: const Duration(milliseconds: 1500),
          ));
        },
        onLongPress: () {
          showDialog(
            context: context,
            builder: (_) => EditAttributeValueAlertDialog(
              attribute: attribute,
            ),
          ).then((_) {
            // ignore: invalid_use_of_protected_member
            parent.setState(() {});
            DBService.save();
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).disabledColor,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 4, 0, 2),
                  child: Text(
                    attribute.name,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Theme.of(context).accentColor,
                        ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 10, 8),
                  child: Text(
                    attribute.value.toString(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String text;
  final State parent;
  final bool magicalSkills;

  const Header({this.text, this.parent, this.magicalSkills = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Theme.of(context).accentColor,
                  ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => NewFeatAlertDialog(
                  title: magicalSkills
                      ? 'create new magical skill'
                      : 'create new feat',
                ),
              ).then((feat) {
                if (feat == null) return;
                // ignore: invalid_use_of_protected_member
                parent.setState(() {
                  if (magicalSkills) {
                    character.magicalSkills.add(feat as Feat);
                    DBService.save();
                  } else {
                    character.feats.add(feat as Feat);
                    DBService.save();
                  }
                });
              });
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class MyTile extends StatelessWidget {
  const MyTile(
      {this.title,
      this.body,
      this.parent,
      this.feat,
      this.isMagicalSkill = false});

  final String title;
  final String body;
  final State parent;
  final Feat feat;
  final bool isMagicalSkill;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => EditFeatAlertDialog(
            title: isMagicalSkill ? 'edit magical skill' : 'edit feat',
            name: title,
            description: body,
          ),
        ).then((value) {
          if (value == null) return;
          // ignore: invalid_use_of_protected_member
          parent.setState(() {
            if (value == "remove") {
              // ignore: invalid_use_of_protected_member
              parent.setState(() {
                if (isMagicalSkill) {
                  character.magicalSkills.remove(feat);
                  DBService.save();
                } else {
                  character.feats.remove(feat);
                  DBService.save();
                }
              });
              return;
            }
            final Feat f = value as Feat;
            if (isMagicalSkill) {
              final int index = character.magicalSkills.indexOf(feat);
              character.magicalSkills[index] = f;
              DBService.save();
            } else {
              final int index = character.feats.indexOf(feat);
              character.feats[index] = f;
              DBService.save();
            }
          });
        });
      },
      child: ExpansionTile(
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: Theme.of(context).disabledColor)),
        trailing: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white,
        ),
        onExpansionChanged: (opening) {},
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              body,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}

class NewFeatAlertDialog extends StatelessWidget {
  const NewFeatAlertDialog({
    this.title,
    this.name = "",
    this.description = "",
  });

  final String title;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    String _newFeatName = name;
    String _newFeatDescription = description;
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextFieldWithLabel(
            label: "name",
            inputType: TextInputType.text,
            padding: const EdgeInsets.fromLTRB(10, 30, 20, 0),
            textAlign: TextAlign.left,
            initialValue: name,
            onChanged: (String value) => _newFeatName = value,
          ),
          MyTextFieldWithLabel(
            label: "description",
            inputType: TextInputType.text,
            padding: const EdgeInsets.fromLTRB(10, 30, 20, 0),
            textAlign: TextAlign.left,
            initialValue: description,
            onChanged: (String value) => _newFeatDescription = value,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'cancel',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        TextButton(
          onPressed: () {
            if (_newFeatName == null || _newFeatDescription == null) return;

            final Feat feat = Feat(
              name: _newFeatName,
              description: _newFeatDescription,
            );

            Navigator.pop(context, feat);
          },
          child: Text(
            "create",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }
}

class EditFeatAlertDialog extends StatelessWidget {
  const EditFeatAlertDialog({
    this.title,
    this.name = "",
    this.description = "",
  });

  final String title;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    String _newFeatName = name;
    String _newFeatDescription = description;
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextFieldWithLabel(
            label: "name",
            inputType: TextInputType.text,
            padding: const EdgeInsets.fromLTRB(10, 30, 20, 0),
            textAlign: TextAlign.left,
            initialValue: name,
            onChanged: (String value) => _newFeatName = value,
          ),
          MyTextFieldWithLabel(
            label: "description",
            inputType: TextInputType.text,
            padding: const EdgeInsets.fromLTRB(10, 30, 20, 0),
            textAlign: TextAlign.left,
            initialValue: description,
            onChanged: (String value) => _newFeatDescription = value,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'remove');
          },
          child: Text(
            'delete',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'cancel',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        TextButton(
          onPressed: () {
            if (_newFeatName == null || _newFeatDescription == null) return;

            final Feat feat = Feat(
              name: _newFeatName,
              description: _newFeatDescription,
            );

            Navigator.pop(context, feat);
          },
          child: Text(
            "edit",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }
}

class EditAttributeValueAlertDialog extends StatefulWidget {
  const EditAttributeValueAlertDialog({
    this.attribute,
  });

  final Attribute attribute;

  @override
  _EditAttributeValueAlertDialogState createState() =>
      _EditAttributeValueAlertDialogState();
}

class _EditAttributeValueAlertDialogState
    extends State<EditAttributeValueAlertDialog> {
  String currentValue;
  bool isValueValid = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        widget.attribute.name,
        style: Theme.of(context).textTheme.headline2,
      ),
      content: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                if (!isValueValid) {
                  setState(() {
                    widget.attribute.value = 0;
                    currentValue = 0.toString();
                    isValueValid = true;
                    return;
                  });
                }

                setState(() {
                  widget.attribute.value -= 1;
                  currentValue = widget.attribute.value.toString();
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Icon(
                  Icons.remove,
                  size: 30,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: MyTextFieldWithLabel(
                label: "",
                inputType: TextInputType.number,
                padding: const EdgeInsets.fromLTRB(4, 30, 0, 0),
                textAlign: TextAlign.center,
                initialValue: currentValue ?? widget.attribute.value.toString(),
                onChanged: (value) => currentValue = value,
                onSubmitted: (value) {
                  try {
                    int.parse(value);
                    setState(() {
                      isValueValid = true;
                    });
                  } on FormatException {
                    setState(() {
                      isValueValid = false;
                    });
                  }
                },
                showError: !isValueValid,
                errorText: 'invalid number',
              ),
            ),
            TextButton(
              onPressed: () {
                if (!isValueValid) {
                  setState(() {
                    widget.attribute.value = 0;
                    currentValue = 0.toString();
                    isValueValid = true;
                    return;
                  });
                }

                setState(() {
                  widget.attribute.value += 1;
                  currentValue = widget.attribute.value.toString();
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'cancel',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        TextButton(
          onPressed: () {
            if (!isValueValid) {
              setState(() {});
              return;
            }
            try {
              int.parse(currentValue);
              setState(() {
                isValueValid = true;
              });
            } on FormatException {
              setState(() {
                isValueValid = false;
              });
            }

            widget.attribute.value = int.parse(currentValue);
            Navigator.pop(context);
          },
          child: Text(
            "edit",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }
}
