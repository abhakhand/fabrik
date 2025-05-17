// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'fabrik_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FabrikModel _$FabrikModelFromJson(Map json) => FabrikModel(
  fromJson: json['from_json'] as bool? ?? true,
  toJson: json['to_json'] as bool? ?? true,
);

FabrikField _$FabrikFieldFromJson(Map json) => FabrikField(
  defaultValue: json['default_value'],
  includeFromJson: json['include_from_json'] as bool? ?? true,
  includeToJson: json['include_to_json'] as bool? ?? true,
  name: json['name'] as String?,
);
