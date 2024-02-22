import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//initial fetch

Future<List<Map<String, dynamic>>> fetchPokemonList() async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/?limit=500'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> results = data['results'];
    return results.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to fetch Pokémon list');
  }
}

Future<List<Pokemon>> fetchPokemonDetails(
    List<Map<String, dynamic>> pokemonList) async {
  List<Pokemon> pokemonDetails = [];

  final int pokemonCount = pokemonList.length;

  for (int i = 0; i < pokemonCount; i++) {
    final pokemon = pokemonList[i];
    final response = await http.get(Uri.parse(pokemon['url']));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Pokemon newPokemon = Pokemon.fromJson(data);

      // Fetch artwork for the Pokémon
      final artworkResponse = await http.get(Uri.parse(
          'https://img.pokemondb.net/artwork/${newPokemon.name.toLowerCase()}.jpg'));
      if (artworkResponse.statusCode == 200) {
        newPokemon.artworkUrl = artworkResponse.request!.url.toString();
      } else {
        // Handle error fetching artwork
        print('Error fetching artwork for ${newPokemon.name}');
      }

      pokemonDetails.add(newPokemon);
    } else {
      throw Exception('Failed to fetch Pokémon details');
    }
  }

  return pokemonDetails;
}

Future<void> storePokemonDetails(List<Pokemon> pokemonDetails) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonList = pokemonDetails.map((pokemon) => pokemon.toJson()).toList();
  await prefs.setString('pokemonDetails', json.encode(jsonList));
}

void fetchAndStorePokemonData() async {
  try {
    // Fetch Pokémon list
    List<Map<String, dynamic>> pokemonList = await fetchPokemonList();

    // Fetch and store Pokémon details
    List<Pokemon> pokemonDetails = await fetchPokemonDetails(pokemonList);

    // Store the Pokémon details using shared_preferences
    await storePokemonDetails(pokemonDetails);
  } catch (e) {
    // Handle errors
    print('Error fetching and storing Pokémon data: $e');
  }
}

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
}

Future<List<Pokemon>> getPokemonDetailsFromStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('pokemonDetails');
  if (jsonString != null) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Pokemon.fromJson(json)).toList();
  } else {
    throw Exception('No Pokémon details found in storage');
  }
}

void retrievePokemonData() async {
  try {
    List<Pokemon> pokemonDetails = await getPokemonDetailsFromStorage();
    // Now you have the list of Pokémon details, you can use it in your app
  } catch (e) {
    // Handle errors
    print('Error retrieving Pokémon data: $e');
  }
}
