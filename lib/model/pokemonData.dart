import 'dart:convert';

import 'package:webview/model/pokemonModel.dart';
import 'package:http/http.dart' as http;

class pokemonData {
  bool loading = false;
  List<pokemnModel> pokemons = [];
  Future<List<pokemnModel>> getData() async {
    final response = await http.get(
      Uri.parse("https://api.pokemontcg.io/v2/cards?q=hp:10"),
    );
    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> decodedJson = jsonDecode(response.body);
        final List<dynamic> jsonList = decodedJson['data'];
        pokemons = jsonList.map((json) => pokemnModel.fromJson(json)).toList();
        return jsonList.map((json) => pokemnModel.fromJson(json)).toList();
      } catch (e) {
        throw Exception(e.toString());
      }
    } else {
      throw Exception('Unable to fetch pokemons from the REST API');
    }
  }

  searchData(String query) async {
    final response = await http.get(
      Uri.parse("https://api.pokemontcg.io/v2/cards?q=hp:10"),
    );
    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> decodedJson = jsonDecode(response.body);
        final List<dynamic> jsonList = decodedJson['data'];
        pokemons = jsonList.map((json) => pokemnModel.fromJson(json)).toList();
        return jsonList.map((json) => pokemnModel.fromJson(json)).toList();
      } catch (e) {
        throw Exception(e.toString());
      }
    } else {
      throw Exception('Unable to fetch pokemons from the REST API');
    }
  }
}
