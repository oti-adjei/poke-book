import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pokebook/controller/sharedPref.dart';
import 'package:pokebook/model/pokemonModel.dart';

//Main function that is run
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
      final pokemonDetails = await fetchPokemonDetailsInBatches(pokemonList);
      //final pokemonDetails = await fetchPokemonDetailsHelper(pokemonList);

      // Store the fetched Pokémon details
      await storePokemonDetails(pokemonDetails);

      return pokemonDetails;
    }
  } catch (e) {
    throw Exception('Failed to fetch Pokémon details: $e');
  }
}

//function to get the names and list from the first url api
Future<List<Map<String, dynamic>>> fetchPokemonList() async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/?limit=80'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> results = data['results'];
    return results.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to fetch Pokémon list');
  }
}

Future<List<Pokemon>> fetchPokemonDetailsInBatches(
    List<Map<String, dynamic>> pokemonList) async {
  final List<Pokemon> allPokemonDetails = [];

  for (int i = 0; i < pokemonList.length; i += 100) {
    final List<Map<String, dynamic>> batch = pokemonList.sublist(
        i, i + 100 < pokemonList.length ? i + 100 : pokemonList.length);
    final List<Pokemon> batchPokemonDetails =
        await fetchPokemonDetailsHelper(batch);
    allPokemonDetails.addAll(batchPokemonDetails);
  }

  return allPokemonDetails;
}

Future<List<Pokemon>> fetchPokemonDetailsHelper(
    List<Map<String, dynamic>> pokemonList) async {
  // Fetch Pokémon details concurrently
  final List<Future<Pokemon>> pokemonFutures = pokemonList.map((pokemon) async {
    final response = await http.get(Uri.parse(pokemon['url']));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Pokemon newPokemon = Pokemon.fromJson(data);

      // Fetch artwork concurrently
      // final artworkUrl =
      //     'https://img.pokemondb.net/artwork/${newPokemon.name.toLowerCase()}.jpg';
      // final artworkResponse = await http.get(Uri.parse(artworkUrl));
      // if (artworkResponse.statusCode == 200) {
      //   newPokemon.artworkUrl = artworkUrl;
      // } else {
      //   // Handle error fetching artwork
      //   print('Error fetching artwork for ${newPokemon.name}');
      // }

      return newPokemon;
    } else {
      throw Exception('Failed to fetch Pokémon details');
    }
  }).toList();

  // Wait for all Pokémon details to be fetched
  final List<Pokemon> pokemonDetails = await Future.wait(pokemonFutures);

  return pokemonDetails;
}





//after getting the names use it to get all details on each of the pokemons
// Future<List<Pokemon>> fetchPokemonDetailsHelper(
//     List<Map<String, dynamic>> pokemonList) async {
//   List<Pokemon> pokemonDetails = [];

//   for (int i = 0; i < pokemonList.length; i++) {
//     final pokemon = pokemonList[i];
//     final response = await http.get(Uri.parse(pokemon['url']));
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       final Pokemon newPokemon = Pokemon.fromJson(data);
//       final artworkResponse = await http.get(Uri.parse(
//           'https://img.pokemondb.net/artwork/${newPokemon.name.toLowerCase()}.jpg'));
//       if (artworkResponse.statusCode == 200) {
//         newPokemon.artworkUrl = artworkResponse.request!.url.toString();
//       } else {
//         // Handle error fetching artwork
//         print('Error fetching artwork for ${newPokemon.name}');
//       }
//       pokemonDetails.add(newPokemon);
//     } else {
//       throw Exception('Failed to fetch Pokémon details');
//     }
//   }

//   return pokemonDetails;
// }