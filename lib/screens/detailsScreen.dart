import 'package:flutter/material.dart';
import 'package:webview/model/pokemonModel.dart';

class Details extends StatelessWidget {
  List<pokemnModel> pokemons;
  int index;
  Details({required this.pokemons, required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Ink.image(
              height: 240,
              fit: BoxFit.fitHeight,
              image: NetworkImage(
                pokemons[index].imageUrl,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "name :" + pokemons[index].name,
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "artist :" + pokemons[index].artist.toString(),
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
