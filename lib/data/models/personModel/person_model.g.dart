// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      id: json['id'] as String,
      name: json['name'] as String,
      whoIsForYou: json['whoIsForYou'] as String,
      age: json['age'] as int,
      photo: json['photo'] as String?,
      eventsIndexes: (json['eventsIndexes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'whoIsForYou': instance.whoIsForYou,
      'age': instance.age,
      'photo': instance.photo,
      'eventsIndexes': instance.eventsIndexes,
    };
