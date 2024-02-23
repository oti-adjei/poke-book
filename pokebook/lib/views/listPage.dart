import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:pokebook/controller/pokeApi.dart';
import 'package:pokebook/model/pokemonModel.dart';
import 'package:pokebook/views/detailView.dart';
import 'package:pokebook/views/homeView.dart';
import '../utils/customScalfold.dart';
import '../utils/listCard.dart';
import '../utils/PokeAvi.dart';
import '../utils/themeCircle.dart';
import '../utils/themeDialog.dart';

class ListPage extends StatefulWidget {
  final String? searchQuery;
  final Function(ThemeData) onThemeChanged; // Make the searchQuery optional

  const ListPage({Key? key, this.searchQuery, required this.onThemeChanged})
      : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Pokemon>? allPokemon;
  Future<void> getAllPokemon() async {
    List<Pokemon> results = await fetchPokemonDetails();

    setState(() {
      allPokemon = results;
    });
  }

  List<Pokemon> filteredItems = [];
  String _query = '';
  int _currentPage = 0;
  int _perPage = 10;

  void search(String query) {
    if (allPokemon != null) {
      setState(() {
        if (widget.searchQuery != null) {
          _query = widget.searchQuery!;
          filteredItems = allPokemon!
              .where((item) => item.name
                  .toLowerCase()
                  .contains(widget.searchQuery!.toLowerCase()))
              .toList();
        } else {
          _query = query;
          filteredItems = allPokemon!
              .where((item) =>
                  item.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      });
    }
  }

  // void search(String query) {
  //   if (allPokemon != null) {
  //     setState(() {
  //       _query = query;
  //       if (widget.searchQuery != null) {
  //         filteredItems = allPokemon!
  //             .where((item) => item.name
  //                 .toLowerCase()
  //                 .contains(widget.searchQuery!.toLowerCase()))
  //             .toList();
  //       } else {
  //         filteredItems = allPokemon!
  //             .where((item) =>
  //                 item.name.toLowerCase().contains(query.toLowerCase()))
  //             .toList();
  //       }
  //     });
  //     // filteredItems.forEach((element) {
  //     //   print(element.name);
  //     // });
  //   }
  // }

  List<Pokemon> getCurrentPageItems() {
    final int startIndex = _currentPage * _perPage;
    final int endIndex = (startIndex + _perPage).clamp(0, filteredItems.length);
    return filteredItems.sublist(startIndex, endIndex);
  }

  @override
  void initState() {
    super.initState();
    getAllPokemon();
    if (widget.searchQuery != null && widget.searchQuery!.isNotEmpty) {
      search(widget.searchQuery!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
        child: Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: Container(
          margin: EdgeInsets.only(left: 20),
          child: Image.asset(
            "lib/assets/svgviewer.png",
          ),
        ),
        leadingWidth: 100,
        title: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              const TextSpan(
                  text: 'Poke, ',
                  style: TextStyle(
                    fontSize: 20,
                  )),
              TextSpan(
                text: 'book',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
        actions: [
          MyCircularButton(onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ThemeSelectionDialog();
              },
            );
          })
        ],
      ),
      body: allPokemon == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    onChanged: (value) {
                      search(value);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _query.isNotEmpty || widget.searchQuery != null
                      ? filteredItems.isEmpty
                          ? const Center(
                              child: Text(
                                'No Results Found',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          : ListView.builder(
                              itemCount: filteredItems.length,
                              itemBuilder: (context, index) {
                                final pokemon = filteredItems[index];
                                return ListCard(
                                  url: pokemon.artworkUrl ?? '',
                                  name: pokemon.name,
                                  type1: "HI",
                                  type2: "Suiii",
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailView(
                                              name: pokemon.name,
                                              types: pokemon.types,
                                              height: pokemon.height,
                                              weight: pokemon.weight,
                                              abilities: pokemon.abilities,
                                              hp: pokemon.hp,
                                              attack: pokemon.attack,
                                              defense: pokemon.defense,
                                              specialAttack:
                                                  pokemon.specialAttack,
                                              specialDefense:
                                                  pokemon.specialDefense,
                                              speed: pokemon.speed,
                                              artworkUrl: pokemon.artworkUrl!),
                                        ));
                                  },
                                );
                                // ListTile(
                                //   title: Text(getCurrentPageItems()[index]),
                                // );
                              },
                            )
                      : ListView.builder(
                          itemCount: allPokemon!.length,
                          itemBuilder: (context, index) {
                            final pokemon = allPokemon![index];
                            return ListCard(
                              url: pokemon.artworkUrl ?? '',
                              name: pokemon.name,
                              type1: "HI",
                              type2: "hello",
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailView(
                                        name: pokemon.name,
                                        types: pokemon.types,
                                        height: pokemon.height,
                                        weight: pokemon.weight,
                                        abilities: pokemon.abilities,
                                        hp: pokemon.hp,
                                        attack: pokemon.attack,
                                        defense: pokemon.defense,
                                        specialAttack: pokemon.specialAttack,
                                        specialDefense: pokemon.specialDefense,
                                        speed: pokemon.speed,
                                        artworkUrl: pokemon.artworkUrl!,
                                      ),
                                    ));
                              },
                            );
                            // ListTile(
                            //   title: Text(items[index]),
                            // );
                          },
                        ),
                ),
              ],
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _currentPage == 0
                  ? null
                  : () {
                      setState(() {
                        _currentPage--;
                      });
                    },
            ),
            Text('Page ${_currentPage + 1}'),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: (_currentPage + 1) * _perPage >= filteredItems.length
                  ? null
                  : () {
                      setState(() {
                        _currentPage++;
                      });
                    },
            ),
          ],
        ),
      ),
    ));
  }
}
