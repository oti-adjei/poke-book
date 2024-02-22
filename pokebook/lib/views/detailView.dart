import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView>
    with SingleTickerProviderStateMixin {
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
    return Scaffold(
      body: Column(
        children: [
          // Container A
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                // Container C
                Container(
                  //color: Colors.blue,
                  child: Center(
                    child: Text('Container C'),
                  ),
                ),
                // Container D

                Positioned(
                  top: 0,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(30),
                          bottomStart: Radius.circular(30)),
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 127, 202, 209),
                          const Color.fromARGB(
                            255,
                            61,
                            160,
                            169,
                          )
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp,
                      ),
                    ),
                    child: Center(
                      child: Text('Container D'),
                    ),
                  ),
                ),
                // Widget E (Image)
                Positioned(
                  bottom: 0,
                  left: 70,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset('lib/assets/image-r.png'),
                  ),
                ),
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
              ],
            ),
          ),
          // Container B and About
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.red,
              height: 100,
              child: Column(
                children: [
                  // Container b
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    color: Colors.amber,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Container B Text',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildEmojiContainer(
                                  Icons.emoji_emotions, 'Emoji 1'),
                              _buildEmojiContainer(
                                  Icons.emoji_emotions, 'Emoji 2'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //tab bar and tabbar view
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
