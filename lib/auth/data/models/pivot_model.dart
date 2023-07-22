import 'package:json_annotation/json_annotation.dart';

part 'pivot_model.g.dart';

@JsonSerializable()
class PivotModel {
  @JsonKey(name: 'entity_id')
  int? entityId;

  @JsonKey(name: 'role_id')
  int? roleId;

  @JsonKey(name: 'entity_type')
  String? entityType;

  dynamic scope;

  PivotModel({
    this.entityId,
    this.roleId,
    this.entityType,
    this.scope,
  });

  factory PivotModel.fromJson(Map<String, dynamic> json) =>
      _$PivotModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PivotModelToJson(this);
}
