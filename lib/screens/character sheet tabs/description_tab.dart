import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lallotales_character_creator/services/character.dart';
import 'package:lallotales_character_creator/services/db_service.dart';

Character character;

class DescriptionTab extends StatefulWidget {
  DescriptionTab({Character char}) {
    character = char;
  }

  @override
  _DescriptionTabState createState() => _DescriptionTabState();
}

class _DescriptionTabState extends State<DescriptionTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            character.imagePath == null
                ? Text(
                    character.imagePath ?? 'No image loaded yet',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Theme.of(context).accentColor,
                        ),
                  )
                : Image.file(File(character.imagePath)),
            SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                final PickedFile image =
                    await ImagePicker().getImage(source: ImageSource.gallery);
                setState(() {
                  character.imagePath = image.path;
                  DBService.save();
                });
              },
              child: Text('Add / Change Image'),
            )
          ],
        ),
      ),
    );
  }
}
