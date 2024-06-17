import 'package:json_annotation/json_annotation.dart';

import '../personModel/person_model.dart';
import 'gift_model/gift_model.dart';

part 'event_model.g.dart';
@JsonSerializable(explicitToJson: true)
class EventModel {
  String id;
  String name;
  DateTime date;
  bool willThereBeCelebration;
  List<Gift> gifts;
  String personIndex;

  EventModel({required this.id,required this.name, required this.date, required this.willThereBeCelebration, required this.gifts, required this.personIndex});

  factory EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}