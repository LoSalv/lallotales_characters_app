class Character {
  Character({this.name, this.race, this.hp});

  String name = "name";
  String race = "race";
  int hp = 0;

  @override
  String toString() {
    return name + ", " + race;
  }
}

List<Character> characterList = [
  new Character(hp: 10, name: "Mech", race: "Elf")
];
