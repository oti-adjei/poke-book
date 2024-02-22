import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';

class PokeAvi extends StatelessWidget {
  const PokeAvi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RowSuper(
        innerDistance: -35.0,
        invert: true,
        children: [
          exampleh(),
          example3(),
        ],
      ),
    );
  }

  Widget example1() => Container(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        //color: Colors.yellow,
        height: 200,
        width: 100,
        child: Image.asset("lib/assets/meow.png"),
      );
  Widget example2() => Container(
        //color: Colors.green,
        height: 200,
        width: 200,
        child: Image.asset("lib/assets/image-r.png"),
      );
  Widget exampleh() => RowSuper(invert: true, innerDistance: -45.0, children: [
        example1(),
        example2(),
      ]);
  Widget example3() => Container(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        //color: Colors.blue,
        height: 200,
        width: 100,
        child: Image.asset("lib/assets/meow.png"),
      );

  //Widget example2() => Image.asset("lib/assets/image-r.png");
}
