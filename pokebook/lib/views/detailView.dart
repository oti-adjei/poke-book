import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  final String name;
  final List<String> types;
  final int height;
  final int weight;
  final List<String> abilities;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
  final String artworkUrl;

  DetailView({
    Key? key,
    required this.name,
    required this.types,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
    required this.artworkUrl,
  }) : super(key: key);

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
                    child: Image.network(widget.artworkUrl),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 60,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.white,
                      ),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Container B and About
          Expanded(
            flex: 5,
            child: Container(
              //color: Colors.red,
              height: 100,
              child: Column(
                children: [
                  // Container b
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0,
                              2), // Change the y offset to control shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(color: Colors.black, fontSize: 20),
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
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child:
                                  Text('About', style: TextStyle(fontSize: 24)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: _buildInfoRow(
                                  'Height', widget.height.toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: _buildInfoRow(
                                  'Weight', widget.weight.toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: _buildInfoRow(
                                  'Abilities', 'Strength, Agility'),
                            ),
                          ],
                        ),
                        // second tab bar view widget
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:
                                  Text('Stats', style: TextStyle(fontSize: 24)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: _buildStatRow('HP', widget.hp),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: _buildStatRow('Attack', widget.attack),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: _buildStatRow('Defense', widget.defense),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: _buildStatRow('Speed', widget.speed),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: _buildStatRow(
                                  'Special Attack', widget.specialAttack),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: _buildStatRow(
                                  'Special Defense', widget.specialDefense),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Similar',
                                  style: TextStyle(fontSize: 24)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(title: Text('Pokemon 1')),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(title: Text('Pokemon 2')),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(title: Text('Pokemon 3')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10),
                    child: Container(
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
