import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lallotales_character_creator/services/character.dart';
import 'package:lallotales_character_creator/services/db_service.dart';
import 'package:lallotales_character_creator/utilities/my_text_field.dart';

Character character;

class InventoryTab extends StatefulWidget {
  InventoryTab({Character char}) {
    character = char;
  }

  @override
  _InventoryTabState createState() => _InventoryTabState();
}

class _InventoryTabState extends State<InventoryTab> {
  // ignore: avoid_void_async
  void _showPopupMenu() async {
    await showMenu(
      color: Theme.of(context).accentColor,
      context: context,
      position: const RelativeRect.fromLTRB(100, 1000, 0, 0),
      items: [
        PopupMenuItem(
          value: 1,
          child: Text(
            "create new item",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Text(
            "create new section",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == null) return;
      if (value == 1) {
        //create new item
        if (character.inventorySections.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'before creating an item, you have to create a section where to put it!',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            duration: const Duration(seconds: 5),
          ));
          return;
        }
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const NewItemAlertDialog(
            title: 'create new item',
            button: 'create',
          ),
        ).then((value) {
          if (value == null) return;

          final String sectionName = value[1] as String;
          final String objectName = value[0] as String;

          setState(() {
            character.inventorySections
                .firstWhere((element) => element.name == sectionName)
                .objects
                .add(objectName);
          });
          DBService.save();
        });
      } else if (value == 2) {
        //create new section
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const NewSectionAlertDialog(
            title: 'create new section',
            button: 'create',
          ),
        ).then((item) {
          if (item == null) return;
          setState(() {
            character.inventorySections
                .add(InventorySection(name: item as String));
            DBService.save();
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<InventorySectionList> _inventorySections =
        character.inventorySections
            .map<InventorySectionList>(
              (e) => InventorySectionList(
                parent: this,
                inventorySection: e,
              ),
            )
            .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: _inventorySections,
      ),
      floatingActionButton: GestureDetector(
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          onPressed: () {
            _showPopupMenu();
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class InventorySectionList extends StatelessWidget {
  final State parent;
  final InventorySection inventorySection;

  const InventorySectionList(
      {@required this.parent, @required this.inventorySection});

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = inventorySection.objects
        .map<Widget>((e) => ListItem(
              object: e,
              parent: parent,
              inventorySection: inventorySection,
            ))
        .toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(inventorySection, parent),
          ...items,
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header(this.inventorySection, this.parent);
  final InventorySection inventorySection;
  final State parent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onLongPress: () {
                showDialog(
                  builder: (_) => ConfirmAlertDialog(
                    title: 'Remove the section "${inventorySection.name}"?',
                    content: 'All objects in the section will be lost too.',
                  ),
                  context: context,
                ).then((value) {
                  if (value == null) return;
                  if (value == true) {
                    // ignore: invalid_use_of_protected_member
                    parent.setState(() {
                      character.inventorySections.remove(inventorySection);
                      DBService.save();
                    });
                  }
                });
              },
              child: Text(
                inventorySection.name,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmAlertDialog extends StatelessWidget {
  const ConfirmAlertDialog({this.title, this.content = ""});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "cancel",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(
            "confirm",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}

class NewItemAlertDialog extends StatefulWidget {
  const NewItemAlertDialog({
    this.title,
    this.name = "",
    this.description = "",
    @required this.button,
  });

  final String title;
  final String name;
  final String description;
  final String button;

  @override
  _NewItemAlertDialogState createState() => _NewItemAlertDialogState();
}

class _NewItemAlertDialogState extends State<NewItemAlertDialog> {
  bool _showNameCantBeEmpty = false;
  String dropdownValue = character.inventorySections[0].name;

  @override
  Widget build(BuildContext context) {
    String _newItemName = widget.name;

    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.headline2,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton(
            value: dropdownValue,
            dropdownColor: Theme.of(context).accentColor,
            onChanged: (newValue) {
              setState(() {
                dropdownValue = newValue as String;
              });
            },
            icon: const Icon(Icons.arrow_downward),
            style: Theme.of(context).textTheme.bodyText1,
            underline: Container(
              height: 2,
              color: Theme.of(context).accentColor,
            ),
            items:
                character.inventorySections.map<DropdownMenuItem<String>>((e) {
              return DropdownMenuItem<String>(
                value: e.name,
                child: Text(
                  e.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          MyTextFieldWithLabel(
            showError: _showNameCantBeEmpty,
            errorText: "the name of the object can't be empty",
            label: "name",
            inputType: TextInputType.text,
            padding: const EdgeInsets.fromLTRB(10, 30, 20, 0),
            textAlign: TextAlign.left,
            initialValue: widget.name,
            onChanged: (String value) => _newItemName = value,
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
            if (_newItemName.isEmpty) {
              setState(() {
                _showNameCantBeEmpty = true;
              });
              return;
            }
            Navigator.pop(context, [_newItemName, dropdownValue]);
          },
          child: Text(
            widget.button,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }
}

class NewSectionAlertDialog extends StatefulWidget {
  const NewSectionAlertDialog({
    this.title,
    this.name = "",
    this.description = "",
    @required this.button,
  });

  final String title;
  final String name;
  final String description;
  final String button;

  @override
  _NewSectionAlertDialogState createState() => _NewSectionAlertDialogState();
}

class _NewSectionAlertDialogState extends State<NewSectionAlertDialog> {
  bool _showError = false;

  @override
  Widget build(BuildContext context) {
    String _newSectionName = widget.name;
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.headline2,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          MyTextFieldWithLabel(
            label: "",
            inputType: TextInputType.text,
            padding: const EdgeInsets.fromLTRB(10, 30, 20, 0),
            textAlign: TextAlign.left,
            initialValue: widget.name,
            onChanged: (String value) => {_newSectionName = value},
            showError: _showError,
            errorText: "can't be empty",
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
            if (_newSectionName.isEmpty) {
              setState(() {
                _showError = true;
              });
              return;
            }
            if (_newSectionName == null) return;

            Navigator.pop(context, _newSectionName);
          },
          child: Text(
            widget.button,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  final String object;
  final State parent;
  final InventorySection inventorySection;

  const ListItem({this.inventorySection, this.object, this.parent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          builder: (_) => ConfirmAlertDialog(
              title:
                  'Remove the object "$object" from the section "${inventorySection.name}"?'),
          context: context,
        ).then((value) {
          if (value == null) return;
          if (value == true) {
            // ignore: invalid_use_of_protected_member
            parent.setState(() {
              inventorySection.objects.remove(object);
            });
          }
        });
      },
      child: Card(
        color: Theme.of(context).accentColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 15, 8, 10),
          child: Text(
            object,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
