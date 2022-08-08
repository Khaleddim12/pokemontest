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
  List<pokemnModel> pokemons = []; //ulist
  List<pokemnModel> poks = []; //userList
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
        poks = pokemons;
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
            buildSearch(),
            Expanded(
              child: FutureBuilder(
                  future: pokemonData().getData(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<pokemnModel> pokemons = snapshot.data;
                        return GridView.builder(
                            physics: ClampingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 4.0),
                            itemCount: pokemons.length,
                            itemBuilder: (context, index) {
                              return pokemonWidget(
                                pokemons: poks,
                                index: index,
                              );
                            });
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

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Enter Name',
        onChanged: searrchPokemon,
      );

  Future searrchPokemon(String query) async => debounce(() async {
        pokemons = await pokemonData().searchData(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.poks = pokemons;
        });
      });
}


