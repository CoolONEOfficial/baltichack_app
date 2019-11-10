import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Place.g.dart';

@JsonSerializable(nullable: false)
class Place {
  final String name;
  final double rating;
  final String description;
  @_Converter()
  final TimeOfDay open;
  @_Converter()
  final TimeOfDay close;
  final String videoUrl;
  final double lat, lng;

  Place(
    this.name,
    this.description,
    this.open,
    this.close,
    this.videoUrl,
    this.lat,
    this.lng,
    this.rating,
  );

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}

class _Converter implements JsonConverter<TimeOfDay, String> {
  const _Converter();

  @override
  TimeOfDay fromJson(String s) {
    return TimeOfDay(
        hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
  }

  @override
  String toJson(TimeOfDay object) {
    return object.hour.toString() + ':' + object.minute.toString();
  }
}
