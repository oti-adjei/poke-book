import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
        name: json['name'] as String,
        types: (json['types'] as List<dynamic>)
            .map((type) => type['type']['name'] as String)
            .toList(),
        height: json['height'] as int,
        weight: json['weight'] as int,
        abilities: (json['abilities'] as List<dynamic>)
            .map((ability) => ability['ability']['name'] as String)
            .toList(),
        hp: json['hp'] as int,
        attack: json['attack'] as int,
        defense: json['defense'] as int,
        specialAttack: json['specialAttack'] as int,
        specialDefense: json['specialDefense'] as int,
        speed: json['speed'] as int,
        artworkUrl:
            json['artworkUrl'] as String?); // Use optional type for flexibility
  }

  // Pokemon.fromJson(Map<String, dynamic> json) :
  // name = json['name'] as String,
  // types = (json['types'] as List<dynamic>)
  //     .map((type) => type['type']['name'] as String)
  //     .toList(),
  // height = json['height'] as int,
  // weight = json['weight'] as int,
  // abilities = (json['abilities'] as List<dynamic>)
  //     .map((ability) => ability['ability']['name'] as String)
  //     .toList(),
  // hp = json['stats'][0]['base_stat'] as int,
  // attack = json['stats'][1]['base_stat'] as int,
  // defense = json['stats'][2]['base_stat'] as int,
  // specialAttack = json['stats'][3]['base_stat'] as int,
  // specialDefense = json['stats'][4]['base_stat'] as int,
  // speed = json['stats'][5]['base_stat'] as int,
  // artworkUrl = _extractAndValidateArtworkUrl(json);

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

class Wee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pokemon App'),
        ),
        body: FutureBuilder<List<Pokemon>>(
          future: fetchPokemonDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final pokemon = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(pokemon.artworkUrl ??
                          ''), // No matter how big it is, it won't overflow
                    ),
                    title: Text(pokemon.name),
                    subtitle: Text('Type: ${pokemon.types.join(', ')}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Pokemon>> fetchPokemonDetails() async {
    try {
      final storedPokemonDetails = await getPokemonDetailsFromStorage();
      if (storedPokemonDetails.isNotEmpty) {
        if (kDebugMode) {
          print(storedPokemonDetails);
        }
        return storedPokemonDetails;
      } else {
        final pokemonList = await fetchPokemonList();
        final pokemonDetails = await fetchPokemonDetailsHelper(pokemonList);

        // Store the fetched Pokémon details
        await storePokemonDetails(pokemonDetails);

        return pokemonDetails;
      }
    } catch (e) {
      throw Exception('Failed to fetch Pokémon details: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchPokemonList() async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/?limit=10'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to fetch Pokémon list');
    }
  }

  Future<List<Pokemon>> fetchPokemonDetailsHelper(
      List<Map<String, dynamic>> pokemonList) async {
    List<Pokemon> pokemonDetails = [];

    for (int i = 0; i < pokemonList.length; i++) {
      final pokemon = pokemonList[i];
      final response = await http.get(Uri.parse(pokemon['url']));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Pokemon newPokemon = Pokemon.fromJson(data);
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

  Future<List<Pokemon>> getPokemonDetailsFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('pokemon_details');
    if (jsonString != null) {
      debugPrint("Retrieved Pokémon details from storage:");
      //debugPrint(jsonString, wrapWidth: 1024);
      final List<dynamic> pokemonData = jsonDecode(jsonString);
      //debugPrint(pokemonData as String?);
      List<Pokemon> pokemonLis =
          pokemonData.map((data) => Pokemon.fromStoreJson(data)).toList();
      if (kDebugMode) {
        print(pokemonLis);
      }
      return pokemonLis;
    } else {
      debugPrint("No Pokémon details found in storage");
      return [];
    }
  }

  Future<void> storePokemonDetails(List<Pokemon> pokemonDetails) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(pokemonDetails);
    if (jsonString != null) {
      debugPrint('Storing Pokémon details:');
      debugPrint(jsonString);
      await prefs.setString('pokemon_details', jsonString);
    } else {
      debugPrint('Failed to encode Pokémon details');
    }
  }

  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}


// Future<void> storePokemonDetails(List<Pokemon> pokemonDetails) async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonList = pokemonDetails.map((pokemon) => pokemon.toJson()).toList();
//     await prefs.setString('pokemonDetails', json.encode(jsonList));
//   }

//   Future<List<Pokemon>> getPokemonDetailsFromStorage() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString('pokemonDetails');
//     if (jsonString != null) {
//       final List<dynamic> jsonList = json.decode(jsonString);
//       return jsonList.map((json) => Pokemon.fromJson(json)).toList();
//     } else {
//       print('No Pokémon details found in storage');
//       return []; // Return an empty list if no details are found
//     }
//   }
//!ignore
// Future saveJsonData(jsonData) async {
//     final prefs = await SharedPreferences.getInstance();
//     var saveData = jsonEncode(jsonData);
//     await prefs.setString('jsonData', saveData);
//   }

//   Future<void> getJsonData() async {
//     final prefs = await SharedPreferences.getInstance();
//     var temp = prefs.getString('jsonData') ?? jsonEncode(defaultData);
//     debugPrint('Data received: $temp');
//     var data = HomePageModel.fromMap(jsonDecode(temp.toString()));
//     debugPrint('Name: ${(data.name.toString())}');
//     debugPrint('Age: ${(data.age.toString())}');
//   }