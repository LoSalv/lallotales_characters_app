class Character {
  Character({
    this.name = "",
    this.race = "",
    this.hp = "",
    this.exp = "",
    this.wealth = "",
    this.bulk = "",
    this.languages = "",
    this.age = "",
    this.gender = "",
    this.height = "",
    this.maxHp = "",
    this.guard = "",
    this.link = "",
    this.stance = "",
    this.objective = "",
    List<Feat> feats,
    List<Feat> magicalSkills,
    List<InventorySection> inventorySections,
    this.attitude = "",
    this.background = "",
    this.description = "",
    this.imagePath,
  }) {
    this.feats = feats ?? List.empty(growable: true);
    this.magicalSkills = magicalSkills ?? List.empty(growable: true);
    this.inventorySections = inventorySections ?? List.empty(growable: true);

    attributes = [
      Attribute(name: 'athletics', value: 0),
      Attribute(name: 'crafting', value: 0),
      Attribute(name: 'persuasion', value: 0),
      Attribute(name: 'brawl', value: 0),
      Attribute(name: 'knowledge', value: 0),
      Attribute(name: 'performance', value: 0),
      Attribute(name: 'melee', value: 0),
      Attribute(name: 'resolve', value: 0),
      Attribute(name: 'faith', value: 0),
      Attribute(name: 'agility', value: 0),
      Attribute(name: 'deduction', value: 0),
      Attribute(name: 'luck', value: 0),
      Attribute(name: 'stealth', value: 0),
      Attribute(name: 'magic', value: 0),
      Attribute(name: 'society', value: 0),
      Attribute(name: 'perception', value: 0),
      Attribute(name: 'survival', value: 0),
      Attribute(name: 'taming', value: 0),
    ];
  }

  String name;
  String race;
  String hp;
  String exp;
  String wealth;
  String bulk;
  String languages;
  String age;
  String gender;
  String height;
  String maxHp;
  String guard;
  String link;
  String stance;
  String objective;
  String description;
  String background;
  String attitude;
  String imagePath;

  List<Attribute> attributes;

  List<Feat> feats;
  List<Feat> magicalSkills;
  List<InventorySection> inventorySections;

  @override
  String toString() {
    return "$name, $race";
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'race': race,
        'hp': hp,
        'exp': exp,
        'wealth': wealth,
        'bulk': bulk,
        'languages': languages,
        'age': age,
        'gender': gender,
        'height': height,
        'maxHp': maxHp,
        'guard': guard,
        'link': link,
        'stance': stance,
        'objective': objective,
        'description': description,
        'background': background,
        'attitude': attitude,
        'attributes': attributes,
        'feats': feats,
        'magicalSkills': magicalSkills,
        'inventorySections': inventorySections,
        'imagePath': imagePath,
      };

  Character.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        race = json['race'] as String,
        hp = json['hp'] as String,
        exp = json['exp'] as String,
        wealth = json['wealth'] as String,
        bulk = json['bulk'] as String,
        languages = json['languages'] as String,
        age = json['age'] as String,
        gender = json['gendere'] as String,
        height = json['height'] as String,
        maxHp = json['maxHp'] as String,
        guard = json['guard'] as String,
        link = json['link'] as String,
        stance = json['stance'] as String,
        objective = json['objective'] as String,
        description = json['description'] as String,
        background = json['description'] as String,
        attitude = json['attitude'] as String,
        attributes = (json['attributes'] as List)
            .map((e) => Attribute.fromJson(e as Map<String, dynamic>))
            .toList(),
        feats = (json['feats'] as List)
            .map((e) => Feat.fromJson(e as Map<String, dynamic>))
            .toList(),
        magicalSkills = (json['magicalSkills'] as List)
            .map((e) => Feat.fromJson(e as Map<String, dynamic>))
            .toList(),
        inventorySections = (json['inventorySections'] as List)
            .map((e) => InventorySection.fromJson(e as Map<String, dynamic>))
            .toList(),
        imagePath = json['imagePath'] as String;
}

class InventorySection {
  String name;
  List<String> objects;

  InventorySection({this.name, List<String> objects}) {
    this.objects = objects ?? List.empty(growable: true);
  }

  @override
  String toString() {
    return '$name, $objects';
  }

  InventorySection.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        objects = List<String>.from(json['objects'] as List);

  Map<String, dynamic> toJson() => {
        'name': name,
        'objects': objects,
      };
}

class Attribute {
  final String name;
  int value;

  Attribute({this.name, this.value});

  Attribute.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        value = json['value'] as int;

  Map<String, dynamic> toJson() => {
        'name': name,
        'value': value,
      };

  @override
  String toString() {
    return '$name modifier: $value';
  }
}

class Feat {
  String name;
  String description;

  Feat({this.name, this.description});

  Feat.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        description = json['description'] as String;

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
      };

  @override
  String toString() {
    return '$name, $description';
  }
}
