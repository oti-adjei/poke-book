import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pokebook/utils/customScalfold.dart';
import 'package:pokebook/utils/PokeAvi.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pokebook/views/listPage.dart';

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
  Widget build(BuildContext context) {
    return MyCustomScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.07,
              ),
            ),
            PokeAvi(),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'Poke'),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search country...',
              ),
              onSubmitted: (_) {
                _searchCountry();
              },
            ),
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
    );
  }
}
