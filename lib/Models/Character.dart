
// To parse this JSON data, do
//
//     final character = characterFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Character> characterFromJson(String str) => List<Character>.from(json.decode(str).map((x) => Character.fromJson(x)));

String characterToJson(List<Character> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Character extends Equatable{
  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  String image;
  String url;
  String created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.url,
    required this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    species: json["species"],
    type: json["type"],
    gender: json["gender"],
    image: json["image"],
    url: json["url"],
    created: json["created"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "species": species,
    "type": type,
    "gender": gender,
    "image": image,
    "url": url,
    "created": created,
  };

  @override
  List<Object> get props => [id, name, status, species, type, gender, image, url, created,];
}
