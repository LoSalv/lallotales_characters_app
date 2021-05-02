import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lallotales_character_creator/screens/character%20sheet%20tabs/abilities_tab.dart';
import 'package:lallotales_character_creator/screens/character%20sheet%20tabs/description_tab.dart';
import 'package:lallotales_character_creator/screens/character%20sheet%20tabs/inventory_tab.dart';
import 'package:lallotales_character_creator/services/character.dart';
import 'package:lallotales_character_creator/services/db_service.dart';
import 'character sheet tabs/general_info_tab.dart';

class CharacterSheetScreen extends StatefulWidget {
  static String id = "character_sheet_screen";

  @override
  _CharacterSheetScreenState createState() => _CharacterSheetScreenState();
}

class _CharacterSheetScreenState extends State<CharacterSheetScreen> {
  @override
  Widget build(BuildContext context) {
    final int characterIndex = ModalRoute.of(context).settings.arguments as int;
    final Character character = characterList[characterIndex];

    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
              title: Text(character.name),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.face)),
                  Tab(icon: Icon(Icons.accessibility_new_outlined)),
                  Tab(icon: Icon(Icons.stars)),
                  Tab(icon: Icon(Icons.shield)),
                ],
              )),
          body: TabBarView(
            children: [
              GeneralInfoTab(char: character),
              DescriptionTab(character: character),
              AbilitiesTab(char: character),
              InventoryTab(char: character),
            ],
          ),
        ),
      ),
    );
  }
}
