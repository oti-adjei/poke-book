import 'package:flutter/material.dart';

import 'themeCircle.dart';

class ThemeSelectionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choose Theme'),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 300,
            child: MyCircularButton(
              onPressed: () {
                // Change to theme 1
              },
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: MyCircularButton(
              onPressed: () {
                // Change to theme 2
              },
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: MyCircularButton(
              onPressed: () {
                // Change to theme 3
              },
            ),
          ),
        ],
      ),
    );
  }
}
