import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:pokebook/utils/listCard.dart';

var faker = Faker();

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi"),
      ),
      body: Column(
        children: [
          TextField(
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
          filteredItems.isNotEmpty || _query.isNotEmpty
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
                        return
                            //ListCard();
                            ListTile(
                          title: Text(getCurrentPageItems()[index]),
                        );
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
    );
  }
}
