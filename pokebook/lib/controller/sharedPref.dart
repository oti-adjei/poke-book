import 'dart:convert';

import 'package:pokebook/model/pokemonModel.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Pokemon>> getPokemonDetailsFromStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('pokemon_details');
  if (jsonString != null) {
    debugPrint("Retrieved Pokémon details from storage:");
    //debugPrint(jsonString, wrapWidth: 1024);
    final List<dynamic> pokemonData = jsonDecode(jsonString);
    //debugPrint(pokemonData as String?);
    print(pokemonData[0]);
    List<Pokemon> pokemonLis = pokemonData
        .map<Pokemon>((data) => Pokemon.fromStoreJson(data))
        .toList();
    if (kDebugMode) {
      print(pokemonLis);
    }
    return pokemonLis;
  } else {
    debugPrint("No Pokémon details found in storage");
    return [];
  }
}

//store or cahce the data
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
