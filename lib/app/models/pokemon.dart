import 'dart:convert';
import 'package:pokedex/app/models/type.dart';

class Pokemon {
  final int id;
  final String name;
  final String? image;
  final List<Type>? types;
  final int? weight;
  final int? height;
  final List<StatElement>? stats;
  final String? description;

  Pokemon({
    required this.id,
    required this.name,
    this.image,
    this.types,
    this.weight,
    this.height,
    this.stats,
    this.description,
  });

  factory Pokemon.fromRawJson(String str) => Pokemon.fromJson(json.decode(str));

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
    id: json["id"],
    name: json["name"],
    image: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/${json["id"]}.svg',
    types: json["types"] != null ? List<Type>.from(json["types"].map((x) => Type.fromJson(x))) : null,
    weight: json["weight"],
    height: json["height"],
    stats: json["stats"] != null ? List<StatElement>.from(json["stats"].map((x) => StatElement.fromJson(x))) : null,
    description: json["description"],
  );
}

class StatElement {
  final int baseStat;
  final int effort;
  final TypeClass stat;

  StatElement({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory StatElement.fromRawJson(String str) => StatElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StatElement.fromJson(Map<String, dynamic> json) => StatElement(
    baseStat: json["base_stat"],
    effort: json["effort"],
    stat: TypeClass.fromJson(json["stat"]),
  );

  Map<String, dynamic> toJson() => {
    "base_stat": baseStat,
    "effort": effort,
    "stat": stat.toJson(),
  };
}



