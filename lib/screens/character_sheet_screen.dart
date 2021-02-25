import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lallotales_character_creator/screens/character%20sheet%20tabs/abilities_tab.dart';
import 'package:lallotales_character_creator/screens/character%20sheet%20tabs/inventory_tab.dart';
import 'package:lallotales_character_creator/services/character.dart';
import 'character sheet tabs/general_info_tab.dart';

Character character;

class CharacterSheetScreen extends StatefulWidget {
  static String id = "character_sheet_screen";

  @override
  _CharacterSheetScreenState createState() => _CharacterSheetScreenState();
}

class _CharacterSheetScreenState extends State<CharacterSheetScreen> {
  @override
  void initState() {
    super.initState();
    character = characterList[0];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              title: Text(character.name),
              actions: [
                PopupMenuButton(
                  onSelected: (int result) {},
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text('Working a lot harder'),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text('Being a lot smarter'),
                    ),
                    const PopupMenuItem<int>(
                      value: 3,
                      child: Text('Being a self-starter'),
                    ),
                    const PopupMenuItem<int>(
                      value: 4,
                      child: Text('Placed in charge of trading charter'),
                    ),
                  ],
                )
              ],
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.face)),
                  Tab(icon: Icon(Icons.stars)),
                  Tab(icon: Icon(Icons.shield)),
                ],
              )),
          body: TabBarView(
            children: [
              GeneralInfoTab(char: character),
              AbilitiesTab(char: character),
              InventoryTab(char: character),
            ],
          ),
        ),
      ),
    );
  }
}
