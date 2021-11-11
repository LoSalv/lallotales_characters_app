import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'character.dart';

class DBService {
  static Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final String json = jsonEncode(characterList);
    prefs.setString('characters', json);
    print('saved');
    String js = prefs.getString('characters');
    return;
  }

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final String json = prefs.getString('characters');
    if (json == null) return;
    characterList = (jsonDecode(json) as List)
        .map((e) => Character.fromJson(e as Map<String, dynamic>))
        .toList();
    print("loading: $characterList");
    print(characterList[0].imagePath);
    return;
  }
}

List<Character> characterList = [
  Character(
    hp: "10",
    name: "Mech",
    race: "Elf",
    maxHp: "10",
    languages: "common, elvish",
    exp: "0/13",
    age: "27",
    gender: "male",
    wealth: "1 (12)",
    bulk: "5/7",
    height: "175 cm",
    guard: "9",
    link: "bolt medallion",
    stance: "magic must used to do good",
    objective: "learn and do good",
    description:
        "High and thin, definite muscles, long blond hair, pointy ears.",
    attitude: "Easygoing.",
    background: "He was taught by his father.",
    feats: [
      Feat(
          name: 'Arcana Knowledge',
          description:
              '''Mech studied ancient books about the history of the magic. He has +1 to checks to recall knowledge.'''),
    ],
    magicalSkills: [
      Feat(
          name: 'telekinetic projectile',
          description:
              '''Mech throws telekinetically an object of bulk 1 or less, dealing 1d4 to a single target.'''),
      Feat(
          name: 'fire ball',
          description:
              '''Mech can throw a small fire ball to a target, dealing 1d4 fire damage.''')
    ],
    inventorySections: [
      InventorySection(
        name: "wearing",
        objects: [
          "mechanic's clothes",
          "wrench",
        ],
      )
    ],
  ),
];
