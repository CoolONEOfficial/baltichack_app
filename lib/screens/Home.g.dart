// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pref _$PrefFromJson(Map<String, dynamic> json) {
  return Pref(
    json['image'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$PrefToJson(Pref instance) => <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
    };

DataDialogRadios _$DataDialogRadiosFromJson(Map<String, dynamic> json) {
  return DataDialogRadios(
    (json['filters'] as List)
        .map((e) => Filter.fromJson(e as Map<String, dynamic>))
        .toList(),
  )..selected = Filter.fromJson(json['selected'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DataDialogRadiosToJson(DataDialogRadios instance) =>
    <String, dynamic>{
      'selected': instance.selected,
      'filters': instance.filters,
    };

DataDialogNumber _$DataDialogNumberFromJson(Map<String, dynamic> json) {
  return DataDialogNumber()..number = json['number'] as int;
}

Map<String, dynamic> _$DataDialogNumberToJson(DataDialogNumber instance) =>
    <String, dynamic>{
      'number': instance.number,
    };

DataRadio _$DataRadioFromJson(Map<String, dynamic> json) {
  return DataRadio(
    json['value'] as String,
  )..checked = json['checked'] as bool;
}

Map<String, dynamic> _$DataRadioToJson(DataRadio instance) => <String, dynamic>{
      'value': instance.value,
      'checked': instance.checked,
    };

DataCheck _$DataCheckFromJson(Map<String, dynamic> json) {
  return DataCheck()..checked = json['checked'] as bool;
}

Map<String, dynamic> _$DataCheckToJson(DataCheck instance) => <String, dynamic>{
      'checked': instance.checked,
    };

Filter _$FilterFromJson(Map<String, dynamic> json) {
  return Filter(
    json['name'] as String,
    _$enumDecode(_$FilterTypeEnumMap, json['type']),
    json['data'],
  );
}

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'name': instance.name,
      'type': _$FilterTypeEnumMap[instance.type],
      'data': instance.data,
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

const _$FilterTypeEnumMap = <FilterType, dynamic>{
  FilterType.Check: 'Check',
  FilterType.Radio: 'Radio',
  FilterType.DialogNumber: 'DialogNumber',
  FilterType.DialogChecks: 'DialogChecks',
  FilterType.DialogRadios: 'DialogRadios'
};
