import 'package:easy_till/auth/data/models/pivot_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rule_model.g.dart';

@JsonSerializable()
class RoleModel {
  int? id;

  String? name;

  String? title;

  dynamic scope;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  PivotModel? pivot;

  RoleModel({
    this.id,
    this.name,
    this.title,
    this.scope,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RoleModelToJson(this);
}
