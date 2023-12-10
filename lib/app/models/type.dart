import 'dart:convert';

class Type {
  final int slot;
  final TypeClass type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromRawJson(String str) => Type.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    slot: json["slot"],
    type: TypeClass.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "slot": slot,
    "type": type.toJson(),
  };
}

class TypeClass {
  final String name;
  final String url;

  TypeClass({
    required this.name,
    required this.url,
  });

  factory TypeClass.fromRawJson(String str) => TypeClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TypeClass.fromJson(Map<String, dynamic> json) => TypeClass(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}