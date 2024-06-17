import 'package:json_annotation/json_annotation.dart';

part 'gift_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Gift {
  String giftName;
  double price;

  Gift({required this.giftName, required this.price});

  factory Gift.fromJson(Map<String, dynamic> json) => _$GiftFromJson(json);

  Map<String, dynamic> toJson() => _$GiftToJson(this);
}