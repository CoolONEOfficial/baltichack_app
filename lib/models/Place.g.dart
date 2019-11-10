// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return Place(
    json['name'] as String,
    json['description'] as String,
    const _Converter().fromJson(json['open'] as String),
    const _Converter().fromJson(json['close'] as String),
    json['videoUrl'] as String,
    (json['lat'] as num).toDouble(),
    (json['lng'] as num).toDouble(),
    (json['rating'] as num).toDouble(),
  );
}

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'name': instance.name,
      'rating': instance.rating,
      'description': instance.description,
      'open': const _Converter().toJson(instance.open),
      'close': const _Converter().toJson(instance.close),
      'videoUrl': instance.videoUrl,
      'lat': instance.lat,
      'lng': instance.lng,
    };
