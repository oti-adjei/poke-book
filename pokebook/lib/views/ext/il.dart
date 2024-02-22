import 'package:flutter/material.dart';

import '../../utils/customScalfold.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
      child: Column(
        children: [
          // Your blue container
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.blue,
              // Overlaid content (adjust positioning, alignment, etc. as needed)
              child: Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 60,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  Positioned(
                    bottom: -70.0, // Example absolute positioning from bottom
                    left: MediaQuery.of(context).size.width * 0.2,
                    child: Center(
                      child: Image.asset("lib/assets/meow.png"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Container B
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Container B Text',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildEmojiContainer(Icons.emoji_emotions, 'Emoji 1'),
                      _buildEmojiContainer(Icons.emoji_emotions, 'Emoji 2'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Container C
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  // give the tab bar a height [can change hheight to preferred height]                // tab bar view here
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        //first tab bar widget
                        Column(
                          children: [
                            Text('About', style: TextStyle(fontSize: 24)),
                            _buildInfoRow('Height', '5\'7"'),
                            _buildInfoRow('Weight', '150 lbs'),
                            _buildInfoRow('Abilities', 'Strength, Agility'),
                          ],
                        ),
                        // second tab bar view widget
                        Column(
                          children: [
                            Text('Stats', style: TextStyle(fontSize: 24)),
                            _buildStatRow('HP', 100),
                            _buildStatRow('Attack', 80),
                            _buildStatRow('Defense', 70),
                            _buildStatRow('Speed', 90),
                            _buildStatRow('Special Attack', 85),
                            _buildStatRow('Special Defense', 75),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Similar', style: TextStyle(fontSize: 24)),
                            ListTile(title: Text('Pokemon 1')),
                            ListTile(title: Text('Pokemon 2')),
                            ListTile(title: Text('Pokemon 3')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                        color: Colors.white60,
                      ),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        // first tab [you can add an icon using the icon property]
                        Tab(
                          text: 'About',
                        ),

                        // second tab [you can add an icon using the icon property]
                        Tab(
                          text: 'Stats',
                        ),
                        Tab(
                          text: 'Similar',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //  DefaultTabController(
            //   length: 3,
            //   child: Scaffold(
            //     appBar: TabBar(
            //       tabs: [
            //         Tab(text: 'About'),
            //         Tab(text: 'Stats'),
            //         Tab(text: 'Similar'),
            //       ],
            //     ),
            //     body: TabBarView(
            //       children: [
            //         // About tab view
            //         SingleChildScrollView(
            //           child: Column(
            //             children: [
            //               Text('About', style: TextStyle(fontSize: 24)),
            //               _buildInfoRow('Height', '5\'7"'),
            //               _buildInfoRow('Weight', '150 lbs'),
            //               _buildInfoRow('Abilities', 'Strength, Agility'),
            //             ],
            //           ),
            //         ),
            //         // Stats tab view
            //         SingleChildScrollView(
            //           child: Column(
            //             children: [
            //               Text('Stats', style: TextStyle(fontSize: 24)),
            //               _buildStatRow('HP', 100),
            //               _buildStatRow('Attack', 80),
            //               _buildStatRow('Defense', 70),
            //               _buildStatRow('Speed', 90),
            //               _buildStatRow('Special Attack', 85),
            //               _buildStatRow('Special Defense', 75),
            //             ],
            //           ),
            //         ),
            //         // Similar tab view
            //         SingleChildScrollView(
            //           child: Column(
            //             children: [
            //               Text('Similar', style: TextStyle(fontSize: 24)),
            //               ListTile(title: Text('Pokemon 1')),
            //               ListTile(title: Text('Pokemon 2')),
            //               ListTile(title: Text('Pokemon 3')),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmojiContainer(IconData iconData, String text) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(iconData),
          SizedBox(width: 5),
          Text(text),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value),
      ],
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        SizedBox(
          width: 100,
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey,
            value: value / 100,
          ),
        ),
        Text('$value'),
      ],
    );
  }
}


// var widget1 = ...;
// var widget2 = ...;

// RowSuper(  
//   children: [widget1, widget2],    
//   innerDistance: -20.0,
//   );


