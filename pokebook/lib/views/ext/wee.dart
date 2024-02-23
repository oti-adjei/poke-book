import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokebook/controller/pokeApi.dart';
import 'package:pokebook/model/pokemonModel.dart';

class Wee extends StatelessWidget {
  const Wee({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pokemon App'),
        ),
        body: FutureBuilder<List<Pokemon>>(
          future: fetchPokemonDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final pokemon = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(pokemon.artworkUrl ??
                          ''), // No matter how big it is, it won't overflow
                    ),
                    title: Text(pokemon.name),
                    subtitle: Text('Type: ${pokemon.types.join(', ')}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

//custom func to print the json
  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
