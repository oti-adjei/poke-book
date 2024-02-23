import 'package:flutter/material.dart';

import '../theme/amber_theme.dart';
import '../theme/blue_theme.dart';
import '../theme/red_theme.dart';
import 'themeCircle.dart';

class ThemeSelectionDialog extends StatelessWidget {
  final Function(ThemeData) onThemeChanged;

  const ThemeSelectionDialog({Key? key, required this.onThemeChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Choose Theme')),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Adjust alignment as needed
          children: [
            MyCircularButton(
              onPressed: () {
                onThemeChanged(blueTheme);
                Navigator.pop(context);
              },
            ),
            MyCircularButton(
              color: Colors.pink,
              onPressed: () {
                onThemeChanged(redTheme);
                Navigator.pop(context);
              },
            ),
            MyCircularButton(
              color: Colors.amber,
              onPressed: () {
                onThemeChanged(amberTheme);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
