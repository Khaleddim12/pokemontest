import 'package:flutter/material.dart';

import '../model/pokemonModel.dart';
import '../screens/detailsScreen.dart';

class pokemonWidget extends StatelessWidget {
  final List<pokemnModel> pokemons;
  int index;
  pokemonWidget({required this.pokemons, required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Details(
                    index: index,
                    pokemons: pokemons,
                  ),
                ),
              );
            },
            child: Ink.image(
              height: 240,
              fit: BoxFit.fitHeight,
              image: NetworkImage(
                pokemons[index].imageUrl,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            pokemons[index].name,
            style: TextStyle(
                color: Colors.teal, fontSize: 20, fontWeight: FontWeight.bold),
          )
        ])
      ],
    );
  }
}
