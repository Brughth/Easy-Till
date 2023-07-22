// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pivot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PivotModel _$PivotModelFromJson(Map<String, dynamic> json) => PivotModel(
      entityId: json['entity_id'] as int?,
      roleId: json['role_id'] as int?,
      entityType: json['entity_type'] as String?,
      scope: json['scope'],
    );

Map<String, dynamic> _$PivotModelToJson(PivotModel instance) =>
    <String, dynamic>{
      'entity_id': instance.entityId,
      'role_id': instance.roleId,
      'entity_type': instance.entityType,
      'scope': instance.scope,
    };
