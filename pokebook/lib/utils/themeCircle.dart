import 'package:flutter/material.dart';

class MyCircularButton extends StatelessWidget {
  final VoidCallback? onPressed;
  Color? color;

  MyCircularButton({Key? key, this.onPressed, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: CircleBorder(),
            padding: EdgeInsets.zero,
            minimumSize: Size(40, 40) // Remove padding
            ),
        child: Center(
          child: Container(
            width:
                30, // Adjust the size to make it slightly smaller than the outer circle
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  color ?? Theme.of(context).primaryColor, // Use primary color
            ),
          ),
        ),
      ),
    );
  }
}
