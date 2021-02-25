class Character {
  Character({this.name, this.race, this.hp});

  String name = "name";
  String race = "race";
  int hp = 0;

  static getLiz() {
    return Character(name: "Liz", race: "Human");
  }

  @override
  String toString() {
    return name + ", " + race;
  }
}
