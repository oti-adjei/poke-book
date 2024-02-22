import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:pokebook/views/homeView.dart';
import '../utils/customScalfold.dart';
import '../utils/listCard.dart';
import '../utils/PokeAvi.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<String> items = List.generate(50, (index) => faker.food.dish());
  List<String> filteredItems = [];
  String _query = '';
  int _currentPage = 0;
  int _perPage = 10;

  void search(String query) {
    setState(() {
      _query = query;
      filteredItems = items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  List<String> getCurrentPageItems() {
    final int startIndex = _currentPage * _perPage;
    final int endIndex = (startIndex + _perPage).clamp(0, filteredItems.length);
    return filteredItems.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
        child: Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
            );
          },
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: Image.asset(
              "lib/assets/svgviewer.png",
            ),
          ),
        ),
        leadingWidth: 100,
        title: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              const TextSpan(
                  text: 'Poke, ',
                  style: TextStyle(
                    fontSize: 20,
                  )),
              TextSpan(
                text: 'book',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
        actions: [
          MyCircularButton(onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ThemeSelectionDialog();
              },
            );
          })
        ],
      ),
      body: Column(
        children: [
          Container(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                search(value);
              },
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white),
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredItems.isNotEmpty || _query.isNotEmpty
                ? filteredItems.isEmpty
                    ? const Center(
                        child: Text(
                          'No Results Found',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: getCurrentPageItems().length,
                        itemBuilder: (context, index) {
                          return ListCard();
                          // ListTile(
                          //   title: Text(getCurrentPageItems()[index]),
                          // );
                        },
                      )
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(items[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: _currentPage == 0
                  ? null
                  : () {
                      setState(() {
                        _currentPage--;
                      });
                    },
            ),
            Text('Page ${_currentPage + 1}'),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: (_currentPage + 1) * _perPage >= filteredItems.length
                  ? null
                  : () {
                      setState(() {
                        _currentPage++;
                      });
                    },
            ),
          ],
        ),
      ),
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
