// import 'package:json_annotation/json_annotation.dart';

// // part 'product_model.g.dart';

// // @JsonSerializable()
class ProductModel {
  int id;

  String name;

  String reference;

  String? description;

  int unitPrice;

  int? stockLimit;

  int shopId;

  int? stockManagment;

  int? quantity;

  String? image;

  int categoryId;

  String? createdAt;

  String? updatedAt;

  int? isPublic;

  int? isFeatured;

  int? publicPrice;

  String? deletedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.reference,
    this.description,
    required this.unitPrice,
    this.stockLimit,
    required this.shopId,
    this.stockManagment,
    this.quantity,
    this.image,
    required this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.isPublic,
    this.isFeatured,
    this.publicPrice,
    this.deletedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      reference: json['reference'],
      unitPrice: json['unit_price'],
      shopId: json['shop_id'],
      quantity: json['quantity'],
      categoryId: json['category_id'],
    );
  }

  // factory ProductModel.fromJson(Map<String, dynamic> json) =>
  //     _$ProductModelFromJson(json);

  // Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}


// {
//         "id": 13,
//         "name": "Mangues",
//         "reference": "PRO-2-0007",
//         "description": null,
//         "unit_price": 200,
//         "stock_limit": 0,
//         "shop_id": 2,
//         "stock_managment": 0,
//         "quantity": null,
//         "image": null,
//         "category_id": 1,
//         "created_at": "2022-10-30T21:41:36.000000Z",
//         "updated_at": "2022-10-30T21:41:36.000000Z",
//         "is_public": 0,
//         "is_featured": 0,
//         "public_price": 0,
//         "deleted_at": null
//     },