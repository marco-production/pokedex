import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/app/models/pokemon.dart';


class PokemonProvider extends ChangeNotifier {

  int _pokemonId = 0;
  final List<Pokemon> _pokemons = [];
  final Uri uri = Uri.https('pokeapi.co', '/api/v2/pokemon');

  // Getters & Setters
  List<Pokemon> get pokemons => _pokemons;

  /// Get Pokemon List
  Future<List<Pokemon>?> getPokemons(int offset, {int limit = 20}) async {

    var response = await http.get(uri.replace(queryParameters: {'offset': offset.toString(), 'limit' : limit.toString()}));

    if(response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      List<dynamic> data = body["results"];

      for (var element in data) {
        element["id"] = ++_pokemonId;
        Pokemon pokemon = Pokemon.fromJson(element);
        _pokemons.add(pokemon);
      }
      
      return _pokemons;
    }

    return null;
  }

  /// Get Pokemon Details
  Future<Pokemon?> getPokemonDetails(Pokemon pokemon) async {

    try {
      final uri = Uri.https('pokeapi.co', '/api/v2/pokemon/${pokemon.id}');
      final uriDescription = Uri.https('pokeapi.co', '/api/v2/pokemon-species/${pokemon.id}');

      // Get pokemon data & then pokemon description
      final Pokemon data = await http.get(uri)
        .then((response) async {
            final descriptionResponse = await http.get(uriDescription);

            final Map<String, dynamic> pokemonBody = json.decode(response.body);
            final Map<String, dynamic> descriptionBody = json.decode(descriptionResponse.body);

            final description = descriptionBody["flavor_text_entries"][0]["flavor_text"];
            pokemonBody["description"] = description.replaceAll("\n", " ");

            return Pokemon.fromJson(pokemonBody);
      });

      return data;

    } catch(_) {
      return null;
    }
  }
}