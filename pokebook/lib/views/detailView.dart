import 'package:flutter/material.dart';

import '../utils/customScalfold.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
        child: Center(
      child: Text("detail View"),
    ));
  }
}


var widget1 = ...;
var widget2 = ...;

RowSuper(  
  children: [widget1, widget2],    
  innerDistance: -20.0,
  );