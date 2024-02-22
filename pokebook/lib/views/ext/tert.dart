import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

class MyCardr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              //this will help see the full card
              margin: EdgeInsets.all(16),
              color: Colors.transparent,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(10),
              //       bottomRight: Radius.circular(10)),
              //   color: Colors.blue,
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    // this color should help explain
                    //color: Colors.blueAccent,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Stack(
                      children: [
                        //Upper half container
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                            )),
                        //inside grey container
                        Positioned(
                          left: 0,
                          bottom: 10,
                          right: 0,
                          child: Container(
                            height: 218,
                            margin:
                                EdgeInsets.all(10), // Adjust height as needed
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        // Image positioned to overflow the grey container
                        Positioned(
                          left: 20,
                          height: 280,
                          child: Image.asset(
                            'lib/assets/image-r.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Grey background container
                      ],
                    ),
                  ),
                  // Info side
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Title',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.emoji_emotions),
                                  SizedBox(width: 5),
                                  Text('Emoji 1'),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.emoji_emotions),
                                  SizedBox(width: 5),
                                  Text('Emoji 2'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              //this will help see the full card
              margin: EdgeInsets.all(16),
              color: Colors.transparent,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(10),
              //       bottomRight: Radius.circular(10)),
              //   color: Colors.blue,
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    // this color should help explain
                    color: Colors.blueAccent,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Stack(
                      children: [
                        //Upper half container
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                            )),
                        //inside grey container
                        Positioned(
                          left: 0,
                          bottom: 10,
                          right: 0,
                          child: Container(
                            height: 200,
                            margin:
                                EdgeInsets.all(10), // Adjust height as needed
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        // Image positioned to overflow the grey container
                        Positioned(
                          left: 20,
                          height: 280,
                          child: Image.asset(
                            'lib/assets/image-r.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Grey background container
                      ],
                    ),
                  ),
                  // Info side
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Title',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.emoji_emotions),
                                  SizedBox(width: 5),
                                  Text('Emoji 1'),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.emoji_emotions),
                                  SizedBox(width: 5),
                                  Text('Emoji 2'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              //this will help see the full card
              margin: EdgeInsets.all(16),
              color: Colors.transparent,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(10),
              //       bottomRight: Radius.circular(10)),
              //   color: Colors.blue,
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    // this color should help explain
                    color: Colors.blueAccent,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Stack(
                      children: [
                        //Upper half container
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                            )),
                        //inside grey container
                        Positioned(
                          left: 0,
                          bottom: 10,
                          right: 0,
                          child: Container(
                            height: 200,
                            margin:
                                EdgeInsets.all(10), // Adjust height as needed
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        // Image positioned to overflow the grey container
                        Positioned(
                          left: 20,
                          height: 280,
                          child: Image.asset(
                            'lib/assets/image-r.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Grey background container
                      ],
                    ),
                  ),
                  // Info side
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Title',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.emoji_emotions),
                                  SizedBox(width: 5),
                                  Text('Emoji 1'),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.emoji_emotions),
                                  SizedBox(width: 5),
                                  Text('Emoji 2'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              //this will help see the full card
              margin: EdgeInsets.all(16),
              color: Colors.transparent,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(10),
              //       bottomRight: Radius.circular(10)),
              //   color: Colors.blue,
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    // this color should help explain
                    color: Colors.blueAccent,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Stack(
                      children: [
                        //Upper half container
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                            )),
                        //inside grey container
                        Positioned(
                          left: 0,
                          bottom: 10,
                          right: 0,
                          child: Container(
                            height: 200,
                            margin:
                                EdgeInsets.all(10), // Adjust height as needed
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        // Image positioned to overflow the grey container
                        Positioned(
                          left: 20,
                          height: 280,
                          child: Image.asset(
                            'lib/assets/image-r.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Grey background container
                      ],
                    ),
                  ),
                  // Info side
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Title',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.emoji_emotions),
                                  SizedBox(width: 5),
                                  Text('Emoji 1'),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.emoji_emotions),
                                  SizedBox(width: 5),
                                  Text('Emoji 2'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
