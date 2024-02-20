import 'package:flutter/material.dart';

import '../utils/customScalfold.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
        child: Scaffold(
      appBar: AppBar(
        // leading: ,
        title: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              const TextSpan(text: 'Poke, '),
              TextSpan(
                text: 'book',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
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
      body: Center(
        child: Text("Home View"),
      ),
    ));
  }
}

class MyCircularButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const MyCircularButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
      ),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Center(
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

class ThemeSelectionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choose Theme'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
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
