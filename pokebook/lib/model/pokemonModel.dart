class Pokemon {
  final String name;
  final List<String> types;
  final int height;
  final int weight;
  final List<String> abilities;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
  String? artworkUrl;

  Pokemon({
    required this.name,
    required this.types,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
    this.artworkUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'types': types,
      'height': height,
      'weight': weight,
      'abilities': abilities,
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'specialAttack': specialAttack,
      'specialDefense': specialDefense,
      'speed': speed,
      'artworkUrl': artworkUrl
    };
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<String> getTypes(List<dynamic> types) {
      return types.map((type) => type['type']['name'] as String).toList();
    }

    List<String> getAbilities(List<dynamic> abilities) {
      return abilities
          .map((ability) => ability['ability']['name'] as String)
          .toList();
    }

    return Pokemon(
      name: json['name'] as String,
      types: getTypes(json['types']),
      height: json['height'] as int,
      weight: json['weight'] as int,
      abilities: getAbilities(json['abilities']),
      hp: json['stats'][0]['base_stat'] as int,
      attack: json['stats'][1]['base_stat'] as int,
      defense: json['stats'][2]['base_stat'] as int,
      specialAttack: json['stats'][3]['base_stat'] as int,
      specialDefense: json['stats'][4]['base_stat'] as int,
      speed: json['stats'][5]['base_stat'] as int,
    );
  }
  factory Pokemon.fromStoreJson(Map<String, dynamic> json) {
    return Pokemon(
        name: json['name'],
        types: json['types'].map<String>((type) => type.toString()).toList(),
        height: json['height'],
        weight: json['weight'],
        abilities: json['abilities']
            .map<String>((ability) => ability.toString())
            .toList(),
        hp: json['hp'],
        attack: json['attack'],
        defense: json['defense'],
        specialAttack: json['specialAttack'],
        specialDefense: json['specialDefense'],
        speed: json['speed'],
        artworkUrl: json['artworkUrl']
            ?.toString()); // Use optional type for flexibility
  }

// Handle cases where artworkUrl is missing or invalid
  String? _extractAndValidateArtworkUrl(Map<String, dynamic> json) {
    String? url = json['artworkUrl'] as String?;
    if (url == null) {
      // Log a warning or print a message
      print('Warning: Pokemon ${json['name']} has no artwork URL.');
      return null;
    } else if (!Uri.tryParse(url)!.isAbsolute ?? false) {
      // Log a warning or print a message
      print(
          'Warning: Pokemon ${json['name']} has an invalid artwork URL: $url');
      return null;
    } else {
      return url;
    }
  }
}
