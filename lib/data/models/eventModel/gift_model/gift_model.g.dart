// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gift _$GiftFromJson(Map<String, dynamic> json) => Gift(
      giftName: json['giftName'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$GiftToJson(Gift instance) => <String, dynamic>{
      'giftName': instance.giftName,
      'price': instance.price,
    };
