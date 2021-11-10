import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lallotales_character_creator/services/character.dart';

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
    return Scaffold();
  }
}
