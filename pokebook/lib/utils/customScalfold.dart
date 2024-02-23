import 'dart:math';

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
            opacity: 0.3,
            image: AssetImage('lib/assets/noisy-background.jpg'),
            fit: BoxFit.fill, // Adjust as needed
          ),
        ),
        child: child,
      ),
    );
  }
}

class NoisePainter extends CustomPainter {
  final double opacity;
  final int gridSize;
  final Color color;

  NoisePainter({this.opacity = 0.1, this.gridSize = 20, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random();
    final paint = Paint()..color = color.withOpacity(opacity);

    for (var i = 0; i < size.width; i += gridSize) {
      for (var j = 0; j < size.height; j += gridSize) {
        if (random.nextDouble() > 0.5) {
          canvas.drawRect(
              Rect.fromLTWH(i.toDouble(), j.toDouble(), gridSize.toDouble(),
                  gridSize.toDouble()),
              paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
