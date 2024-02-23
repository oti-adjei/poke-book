// Define a PokemonDataProvider class to fetch and hold the data
import 'package:flutter/material.dart';
import 'package:pokebook/controller/pokeApi.dart';
import 'package:pokebook/controller/sharedPref.dart';

import '../model/pokemonModel.dart';

class PokemonDataProvider extends ChangeNotifier {
  List<Pokemon>? _allPokemon;
  List<Pokemon> filteredItems = [];
  String _query = '';

  List<Pokemon>? get allPokemon => _allPokemon;

  Future<void> fetchAllPokemon() async {
    // Fetch data from API and update _allPokemon
    _allPokemon = await fetchPokemonDetails();
    notifyListeners(); // Notify listeners of the data change
  }

  void search(String query) {
    if (allPokemon != null) {
      _query = query;
      filteredItems = allPokemon!
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    await removePokemonDetails();
    await fetchAllPokemon();
  }
}
