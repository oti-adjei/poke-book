import 'package:flutter/material.dart';
import 'package:pokebook/utils/customScalfold.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
        child: Center(
      child: Text("List View"),
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
