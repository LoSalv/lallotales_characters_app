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

class _CharacterSheetScreenState extends State<CharacterSheetScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int characterIndex = ModalRoute.of(context).settings.arguments as int;
    final Character character = characterList[characterIndex];
    final Color notSelectedIconColor = Theme.of(context).disabledColor;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Theme.of(context).accentColor,
          title: Text(character.name),
          bottom: TabBar(
            indicatorColor: Theme.of(context).accentColor,
            controller: _tabController,
            tabs: [
              Tab(
                icon: Icon(Icons.face,
                    color: _tabController.index == 0
                        ? Theme.of(context).accentColor
                        : notSelectedIconColor),
              ),
              Tab(
                icon: Icon(Icons.accessibility_new_outlined,
                    color: _tabController.index == 1
                        ? Theme.of(context).accentColor
                        : notSelectedIconColor),
              ),
              Tab(
                icon: Icon(Icons.stars,
                    color: _tabController.index == 2
                        ? Theme.of(context).accentColor
                        : notSelectedIconColor),
              ),
              Tab(
                icon: Icon(
                  Icons.shield,
                  color: _tabController.index == 3
                      ? Theme.of(context).accentColor
                      : notSelectedIconColor,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            GeneralInfoTab(char: character),
            DescriptionTab(char: character),
            AbilitiesTab(char: character),
            InventoryTab(char: character),
          ],
        ),
      ),
    );
  }
}
