import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pokebook/utils/customScalfold.dart';
import 'package:pokebook/views/testd.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> countries = [
    'United States',
    'Canada',
    'India',
    'Australia',
    'United Kingdom',
    'Germany',
    'Serbia',
    'Malaysia',
    'Peru',
    'Brazil',
    'China',
    'Japan',
    'Mexico',
    'France',
    'Italy',
    'South Korea',
    'Spain',
    'Russia',
    'Netherlands',
    'Switzerland',
    // Add more countries as needed...
  ];

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible;
    return MyCustomScaffold(
        child: KeyboardVisibilityBuilder(
            builder: (context, isVisible) => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.07)),
                      Overst(),
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
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
                      TypeAheadField(
                        builder: (context, controller, focusNode) {
                          return TextField(
                            focusNode: focusNode,
                            autofocus: true,
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText: 'Search country...',
                            ),
                          );
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSelected: (suggestion) {
                          // Handle when a suggestion is selected.
                          _controller.text = suggestion;
                          print('Selected country: $suggestion');
                        },
                        suggestionsCallback: (pattern) {
                          return countries
                              .where((country) => country
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()))
                              .toList();
                        },
                      ),
                      const Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text("View all"),
                      )
                    ],
                  ),
                )));
  }
}
