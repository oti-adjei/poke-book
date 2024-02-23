import 'package:flutter/material.dart';
import 'package:pokebook/utils/pokemonProvider.dart';
import 'package:pokebook/views/ext/wee.dart';
import 'package:pokebook/views/homeView.dart';
import 'package:pokebook/views/listPage.dart';
import 'package:provider/provider.dart';

import 'theme/blue_theme.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => PokemonDataProvider(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _currentTheme = blueTheme; // Set initial theme

  void _changeTheme(ThemeData theme) {
    setState(() {
      _currentTheme = theme;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _currentTheme,
      home: HomeView(
        onThemeChanged: _changeTheme,
      ),
      //    const DetailView(),
      //const HomeView(),
      //Wee(),
    );
  }
}
