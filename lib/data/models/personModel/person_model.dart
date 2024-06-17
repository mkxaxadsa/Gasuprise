import 'dart:io';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

import '../eventModel/event_model.dart';

part 'person_model.g.dart';


@JsonSerializable(explicitToJson: true)
class Person {
  String id;
  String name;
  String whoIsForYou;
  int age;
  String? photo;
  List<String> eventsIndexes;

  Person(
      {
        required this.id,
        required this.name,
      required this.whoIsForYou,
      required this.age,
       this.photo,
      required this.eventsIndexes});

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
