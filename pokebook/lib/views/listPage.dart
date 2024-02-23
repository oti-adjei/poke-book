import 'package:flutter/material.dart';
import 'package:pokebook/utils/customScalfold.dart';
import 'package:pokebook/utils/pokemonProvider.dart';
import 'package:provider/provider.dart';
import 'package:pokebook/model/pokemonModel.dart';
import 'package:pokebook/views/detailView.dart';
import '../utils/listCard.dart';
import '../utils/themeCircle.dart';
import '../utils/themeDialog.dart';

class ListPage extends StatelessWidget {
  final String? searchQuery;
  final Function(ThemeData) onThemeChanged;

  const ListPage({Key? key, this.searchQuery, required this.onThemeChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonDataProvider>(context);

    // Trigger fetching data when the ListPage is built
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      pokemonProvider.fetchAllPokemon();
    });

    return _ListPageContent(
      searchQuery: searchQuery,
      onThemeChanged: onThemeChanged,
    );
  }
}

class _ListPageContent extends StatefulWidget {
  final String? searchQuery;

  final Function(ThemeData) onThemeChanged;

  const _ListPageContent(
      {Key? key, this.searchQuery, required this.onThemeChanged})
      : super(key: key);

  @override
  State<_ListPageContent> createState() => _ListPageContentState();
}

class _ListPageContentState extends State<_ListPageContent> {
  List<Pokemon>? allPokemon;
  List<Pokemon> filteredItems = [];
  String _query = '';
  int _currentPage = 0;
  int _perPage = 10;

  Future<void> _refreshData() async {
    final pokemonProvider =
        Provider.of<PokemonDataProvider>(context, listen: false);
    await pokemonProvider.refreshData();
  }

  void search(String query) {
    final pokemonProvider =
        Provider.of<PokemonDataProvider>(context, listen: false);
    setState(() {
      _query = query;
      if (query.isNotEmpty) {
        // If search query is not empty, filter the allPokemon list
        filteredItems = allPokemon!
            .where((pokemon) =>
                pokemon.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        // If search query is empty, assign allPokemon list to filteredItems
        filteredItems = List.from(allPokemon!);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    final pokemonProvider =
        Provider.of<PokemonDataProvider>(context, listen: false);
    if (widget.searchQuery != null && widget.searchQuery!.isNotEmpty) {
      _query = widget.searchQuery!;
      pokemonProvider.search(widget.searchQuery!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonDataProvider>(context);

    return MyCustomScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                    text: 'Poke',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
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
            MyCircularButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ThemeSelectionDialog(
                      onThemeChanged: (theme) => widget.onThemeChanged(theme),
                    );
                  },
                );
              },
              color: Theme.of(context).colorScheme.primary,
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: pokemonProvider.allPokemon == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                color: Colors.grey,
                                width: 1), // Thin grey border
                          ),
                          child: TextField(
                            style: const TextStyle(color: Colors.black),
                            onChanged: (value) {
                              setState(() {
                                _query = value;
                                pokemonProvider.search(value);
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey, // Adjust icon color
                              ),
                              border: InputBorder.none, // Remove default border
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 8), // Adjust padding
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: pokemonProvider.filteredItems.isEmpty
                          ? const Center(
                              child: Text(
                                'No Results Found',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          : ListView.builder(
                              itemCount: pokemonProvider.filteredItems.length,
                              itemBuilder: (context, index) {
                                final pokemon =
                                    pokemonProvider.filteredItems[index];
                                return ListCard(
                                  url: pokemon.artworkUrl ?? '',
                                  name: pokemon.name,
                                  types: pokemon.types,
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
                              },
                            ),
                    ),
                  ],
                ),
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
                onPressed: () {
                  final int nextPage = _currentPage + 1;
                  final int totalItems = pokemonProvider.filteredItems.length;
                  final int maxPage = (totalItems / _perPage).ceil();
                  if (nextPage < maxPage) {
                    setState(() {
                      _currentPage = nextPage;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


                                             



// import 'package:faker/faker.dart';
// import 'package:flutter/material.dart';
// import 'package:pokebook/controller/pokeApi.dart';
// import 'package:pokebook/model/pokemonModel.dart';
// import 'package:pokebook/theme/red_theme.dart';
// import 'package:pokebook/views/detailView.dart';
// import 'package:pokebook/views/homeView.dart';
// import '../controller/sharedPref.dart';
// import '../theme/amber_theme.dart';
// import '../theme/blue_theme.dart';
// import '../utils/customScalfold.dart';
// import '../utils/listCard.dart';
// import '../utils/PokeAvi.dart';
// import '../utils/themeCircle.dart';

// class ListPage extends StatefulWidget {
//   final String? searchQuery;
//   final Function(ThemeData) onThemeChanged; // Make the searchQuery optional

//   const ListPage({Key? key, this.searchQuery, required this.onThemeChanged})
//       : super(key: key);

//   @override
//   State<ListPage> createState() => _ListPageState();
// }

// class _ListPageState extends State<ListPage> {
//   List<Pokemon>? allPokemon;

//   Future<void> getAllPokemon() async {
//     List<Pokemon> results = await fetchPokemonDetails();

//     setState(() {
//       allPokemon = results;
//     });
//   }

//   List<Pokemon> filteredItems = [];
//   String _query = '';
//   int _currentPage = 0;
//   int _perPage = 10;

//   void search(String query) {
//     if (allPokemon != null) {
//       setState(() {
//         if (widget.searchQuery != null) {
//           _query = widget.searchQuery!;
//           filteredItems = allPokemon!
//               .where((item) => item.name
//                   .toLowerCase()
//                   .contains(widget.searchQuery!.toLowerCase()))
//               .toList();
//         } else {
//           _query = query;
//           filteredItems = allPokemon!
//               .where((item) =>
//                   item.name.toLowerCase().contains(query.toLowerCase()))
//               .toList();
//         }
//       });
//     }
//   }

//   // void search(String query) {
//   //   if (allPokemon != null) {
//   //     setState(() {
//   //       _query = query;
//   //       if (widget.searchQuery != null) {
//   //         filteredItems = allPokemon!
//   //             .where((item) => item.name
//   //                 .toLowerCase()
//   //                 .contains(widget.searchQuery!.toLowerCase()))
//   //             .toList();
//   //       } else {
//   //         filteredItems = allPokemon!
//   //             .where((item) =>
//   //                 item.name.toLowerCase().contains(query.toLowerCase()))
//   //             .toList();
//   //       }
//   //     });
//   //     // filteredItems.forEach((element) {
//   //     //   print(element.name);
//   //     // });
//   //   }
//   // }

//   List<Pokemon> getCurrentPageItems() {
//     final int startIndex = _currentPage * _perPage;
//     final int endIndex = (startIndex + _perPage).clamp(0, filteredItems.length);
//     return filteredItems.sublist(startIndex, endIndex);
//   }

//   Future<void> _refreshData() async {
//     await removePokemonDetails();
//     // Fetch data again and update the cache
//     getAllPokemon();
//   }

//   @override
//   void initState() {
//     super.initState();
//     getAllPokemon();
//     if (widget.searchQuery != null && widget.searchQuery!.isNotEmpty) {
//       search(widget.searchQuery!);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return MyCustomScaffold(
//         child: Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         leading: Container(
//           margin: EdgeInsets.only(left: 20),
//           child: Image.asset(
//             "lib/assets/svgviewer.png",
//           ),
//         ),
//         leadingWidth: 100,
//         title: RichText(
//           text: TextSpan(
//             style: DefaultTextStyle.of(context).style,
//             children: <TextSpan>[
//               const TextSpan(
//                   text: 'Poke',
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black)),
//               TextSpan(
//                 text: 'book',
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                     color: Theme.of(context).colorScheme.primary),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           MyCircularButton(onPressed: () {
//             showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return ThemeSelectionDialog(
//                   onThemeChanged: widget.onThemeChanged,
//                 );
//               },
//             );
//           })
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: _refreshData,
//         child: allPokemon == null
//             ? const Center(child: CircularProgressIndicator())
//             : Column(
//                 children: [
//                   Container(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 20, horizontal: 15),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(40),
//                           border: Border.all(
//                               color: Colors.grey, width: 1), // Thin grey border
//                         ),
//                         child: TextField(
//                           style: const TextStyle(color: Colors.black),
//                           onChanged: (value) {
//                             search(value);
//                           },
//                           decoration: InputDecoration(
//                             hintText: 'Search...',
//                             hintStyle: TextStyle(color: Colors.black),
//                             prefixIcon: Icon(
//                               Icons.search,
//                               color: Colors.grey, // Adjust icon color
//                             ),
//                             border: InputBorder.none, // Remove default border
//                             contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 15, horizontal: 8), // Adjust padding
//                           ),
//                         ),
//                       ),
//                     ),
//                     // child: TextField(
//                     //   style: const TextStyle(color: Colors.black),
//                     //   onChanged: (value) {
//                     //     search(value);
//                     //   },
//                     //   decoration: const InputDecoration(
//                     //     hintText: 'Search...',
//                     //     hintStyle: TextStyle(color: Colors.black),
//                     //     fillColor: Colors.white,
//                     //     prefixIcon: Icon(
//                     //       Icons.search,
//                     //       color: Colors.white,
//                     //     ),
//                     //   ),
//                     // ),
//                   ),
//                   Expanded(
//                     child: _query.isNotEmpty || widget.searchQuery != null
//                         ? filteredItems.isEmpty
//                             ? const Center(
//                                 child: Text(
//                                   'No Results Found',
//                                   style: TextStyle(fontSize: 18),
//                                 ),
//                               )
//                             : ListView.builder(
//                                 itemCount: filteredItems.length,
//                                 itemBuilder: (context, index) {
//                                   final pokemon = filteredItems[index];
//                                   return ListCard(
//                                     url: pokemon.artworkUrl ?? '',
//                                     name: pokemon.name,
//                                     type1: "HI",
//                                     type2: "Suiii",
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => DetailView(
//                                                 name: pokemon.name,
//                                                 types: pokemon.types,
//                                                 height: pokemon.height,
//                                                 weight: pokemon.weight,
//                                                 abilities: pokemon.abilities,
//                                                 hp: pokemon.hp,
//                                                 attack: pokemon.attack,
//                                                 defense: pokemon.defense,
//                                                 specialAttack:
//                                                     pokemon.specialAttack,
//                                                 specialDefense:
//                                                     pokemon.specialDefense,
//                                                 speed: pokemon.speed,
//                                                 artworkUrl:
//                                                     pokemon.artworkUrl!),
//                                           ));
//                                     },
//                                   );
//                                   // ListTile(
//                                   //   title: Text(getCurrentPageItems()[index]),
//                                   // );
//                                 },
//                               )
//                         : ListView.builder(
//                             itemCount: allPokemon!.length,
//                             itemBuilder: (context, index) {
//                               final pokemon = allPokemon![index];
//                               return ListCard(
//                                 url: pokemon.artworkUrl ?? '',
//                                 name: pokemon.name,
//                                 type1: "HI",
//                                 type2: "hello",
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => DetailView(
//                                           name: pokemon.name,
//                                           types: pokemon.types,
//                                           height: pokemon.height,
//                                           weight: pokemon.weight,
//                                           abilities: pokemon.abilities,
//                                           hp: pokemon.hp,
//                                           attack: pokemon.attack,
//                                           defense: pokemon.defense,
//                                           specialAttack: pokemon.specialAttack,
//                                           specialDefense:
//                                               pokemon.specialDefense,
//                                           speed: pokemon.speed,
//                                           artworkUrl: pokemon.artworkUrl!,
//                                         ),
//                                       ));
//                                 },
//                               );
//                               // ListTile(
//                               //   title: Text(items[index]),
//                               // );
//                             },
//                           ),
//                   ),
//                 ],
//               ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: _currentPage == 0
//                   ? null
//                   : () {
//                       setState(() {
//                         _currentPage--;
//                       });
//                     },
//             ),
//             Text('Page ${_currentPage + 1}'),
//             IconButton(
//               icon: Icon(Icons.arrow_forward),
//               onPressed: (_currentPage + 1) * _perPage >= filteredItems.length
//                   ? null
//                   : () {
//                       setState(() {
//                         _currentPage++;
//                       });
//                     },
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }

// class ThemeSelectionDialog extends StatelessWidget {
//   final Function(ThemeData) onThemeChanged;

//   const ThemeSelectionDialog({Key? key, required this.onThemeChanged})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Center(child: Text('Choose Theme')),
//       content: Container(
//         height: MediaQuery.of(context).size.height * 0.1,
//         child: Row(
//           mainAxisAlignment:
//               MainAxisAlignment.spaceEvenly, // Adjust alignment as needed
//           children: [
//             MyCircularButton(
//               onPressed: () {
//                 onThemeChanged(blueTheme);
//                 Navigator.pop(context);
//               },
//             ),
//             MyCircularButton(
//               color: Colors.pink,
//               onPressed: () {
//                 onThemeChanged(redTheme);
//                 Navigator.pop(context);
//               },
//             ),
//             MyCircularButton(
//               color: Colors.amber,
//               onPressed: () {
//                 onThemeChanged(amberTheme);
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
