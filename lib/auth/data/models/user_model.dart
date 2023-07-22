import 'package:json_annotation/json_annotation.dart';

import 'package:easy_till/auth/data/models/rule_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  int id;

  String name;

  String email;

  @JsonKey(name: 'email_verified_at')
  String? emailVerifiedAt;

  @JsonKey(name: 'shop_id')
  int shopId;

  int? active;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'deleted_at')
  String? deletedAt;

  List<RoleModel>? roles;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.shopId,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
