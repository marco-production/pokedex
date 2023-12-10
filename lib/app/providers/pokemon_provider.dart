import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonProvider extends ChangeNotifier {

  int _pokemonId = 0;
  final List<Pokemon> _pokemons = [];
  final Uri _uri = Uri.https('pokeapi.co', '/api/v2/pokemon');

  // Getters & Setters
  List<Pokemon> get pokemons => _pokemons;

  Future<List<Pokemon>?> getPokemons(int offset, {int limit = 20}) async {

    var response = await http.get(_uri.replace(queryParameters: {'offset': offset.toString(), 'limit' : limit.toString()}));

    if(response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      List<dynamic> data = body["results"];

      print(data.length);

      for (var element in data) {
        element["id"] = ++_pokemonId;
        Pokemon pokemon = Pokemon.fromJson(element);
        _pokemons.add(pokemon);
      }

      //notifyListeners();

      return _pokemons;

    }

    return null;
  }
}