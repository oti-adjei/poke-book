import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pokebook/utils/customScalfold.dart';
import 'package:pokebook/utils/PokeAvi.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pokebook/utils/pokemonProvider.dart';
import 'package:pokebook/views/listPage.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  final Function(ThemeData) onThemeChanged;

  const HomeView({Key? key, required this.onThemeChanged}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _controller = TextEditingController();

  void _searchCountry() {
    final String input = _controller.text.toLowerCase();
    if (input.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListPage(
            searchQuery: input,
            onThemeChanged: widget.onThemeChanged,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    // Trigger fetching data when the HomeView is initialized
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<PokemonDataProvider>(context, listen: false)
          .fetchAllPokemon();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonDataProvider>(context);

    // Display UI based on data availability
    return pokemonProvider.allPokemon == null
        ? MyCustomScaffold(
            child: Center(
                child: Column(
            children: [CircularProgressIndicator(), Text("Please wait ")],
          )))
        : MyCustomScaffold(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.07,
                      ),
                    ),
                    const PokeAvi(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            const TextSpan(
                                text: 'Poke',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal)),
                            TextSpan(
                              text: 'book',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: Text(
                        "Largest Pokémon index with information about every Pokemon you can think of. ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 30),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              width: 4,
                              color: Colors.pink), // Thick pink border
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                decoration: const InputDecoration(
                                  hintText: 'Search Pokemon...',
                                  border: InputBorder
                                      .none, // Remove the default border
                                ),
                                onSubmitted: (_) {
                                  _searchCountry();
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                _searchCountry();
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.pink,
                                ),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // TextField(
                    //   controller: _controller,
                    //   decoration: const InputDecoration(
                    //     hintText: 'Search country...',
                    //   ),
                    //   onSubmitted: (_) {
                    //     _searchCountry();
                    //   },
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListPage(
                                      onThemeChanged: widget.onThemeChanged,
                                    )),
                          );
                        },
                        child: Text("View all"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
