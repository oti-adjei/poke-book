import 'package:flutter/material.dart';

// Define your custom color
// const LinearGradient detailGradient = LinearGradient(
//       colors: [Color(0xFF7FCAD1), Color(0xFF3DA0A9)], // Define your gradient colors
//       begin: Alignment.topCenter, // Define your gradient begin alignment
//       end: Alignment.bottomCenter, // Define your gradient end alignment
//     ), // Replace YourHexColor with the desired color code

ThemeData redTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Colors.white,
    primary: Colors.blue,
    tertiaryContainer: Color(0xFF3DA0A9),
  ),
);
