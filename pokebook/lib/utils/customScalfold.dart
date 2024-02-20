import 'package:flutter/material.dart';

class MyCustomScaffold extends StatelessWidget {
  final Widget child;

  const MyCustomScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('../assets/noise.png'),
            fit: BoxFit.cover, // Adjust as needed
          ),
        ),
        child: child,
      ),
    );
  }
}
