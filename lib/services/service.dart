import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:webview/model/pokemonData.dart';
import 'package:webview/model/pokemonModel.dart';


Future<pokemonData?> getPokemonData() async {
  pokemnModel? result;
  try {
    final response = await http.get(
      Uri.parse("https://api.pokemontcg.io/v2/cards?q=hp:10"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      result = pokemnModel.fromJson(item);
    } else {
      print("error");
    }
  } catch (e) {
    log(e.toString());
  }
}
