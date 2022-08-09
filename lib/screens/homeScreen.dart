import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview/model/pokemonData.dart';
import 'package:webview/model/pokemonModel.dart';
import '../widgets/pokemonWidget.dart';
import '../widgets/searchWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<pokemnModel> pokemons = [];
  List<pokemnModel> foundPokemons = [];
  String query = '';
  Timer? debouncer;
  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  @override
  void initState() {
    super.initState();
    pokemonData().getData().then((subjectFromServer) {
      setState(() {
        pokemons = subjectFromServer;
        foundPokemons = pokemons;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SearchWidget(
              text: query,
              hintText: 'Enter Name',
              onChanged: searrchPokemon,
            ),
            Expanded(
              child: FutureBuilder(
                  future: pokemonData().getData(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          physics: ClampingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4.0,
                                  mainAxisSpacing: 4.0),
                          itemCount: foundPokemons.length,
                          itemBuilder: (context, index) {
                            return pokemonWidget(
                              pokemons: foundPokemons,
                              index: index,
                            );
                          },
                        );
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
                      return Text("Something Went Wrong");
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future searrchPokemon(String query) async => debounce(() async {
        pokemons = await pokemonData().searchData(query);
        List<pokemnModel> results = [];
        if (!mounted) return;
        if (query.isEmpty) {
          results = pokemons;
        } else {
          results = pokemons.where((pokemon) {
            final nameLower = pokemon.name.toLowerCase();
            final artistLower = pokemon.artist.toString().toLowerCase();
            final searchLower = query.toLowerCase();
            return nameLower.contains(searchLower) ||
                artistLower.contains(searchLower);
          }).toList();
        }
        setState(() {
          this.query = query;
          this.foundPokemons = results;
        });
      });
}
