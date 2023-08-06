// import 'package:json_annotation/json_annotation.dart';

// import 'package:easy_till/auth/data/models/rule_model.dart';

// part 'invoice_model.g.dart';

// @JsonSerializable()
class InvoiceModel {
  // @JsonKey(name: 'till_session_id')
  // final int tillSessionId;

  // @JsonKey(name: 'user_id')
  // final int userId;

  final String reference;

  // @JsonKey(name: 'shop_id')
  // final String shopId;

  // @JsonKey(name: 'customer_name')
  // final String customerName;

  // @JsonKey(name: 'payment_method_id')
  // final String paymentMethodId;

  final double amount;
  InvoiceModel({
    required this.reference,
    required this.amount,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      reference: json['reference'],
      amount: double.parse(json['amount'].toString()),
    );
  }

  // factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
  //     _$InvoiceModelFromJson(json);

  // /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  // Map<String, dynamic> toJson() => _$InvoiceModelToJson(this);
}

// {
//     
//    
//     "customer_id": null,
//     "payment_method_id": 2,
//     "amount": 600,
//     "updated_at": "2023-08-02T17:28:45.000000Z",
//     "created_at": "2023-08-02T17:28:45.000000Z",
//     "id": 32,
//     "lines": [
//         {
//             "id": 111,
//             "invoice_id": 32,
//             "product_id": 1,
//             "product_name": "Mangue",
//             "product_qty": 3,
//             "price": 200,
//             "created_at": "2023-08-02T17:28:45.000000Z",
//             "updated_at": "2023-08-02T17:28:45.000000Z"
//         }
//     ],
//     "seller": {
//         "id": 2,
//         "name": "Wilfried",
//         "email": "loic.ngou98@gmail.com",
//         "email_verified_at": null,
//         "shop_id": 2,
//         "active": 1,
//         "created_at": "2022-10-30T21:39:38.000000Z",
//         "updated_at": "2022-10-30T21:40:37.000000Z",
//         "deleted_at": null
//     },
//     "shop": {
//         "id": 2,
//         "name": "Nick Tech Transparency",
//         "currency_id": 1,
//         "owner_id": 2,
//         "shop_type_id": 1,
//         "created_at": "2022-10-30T21:40:37.000000Z",
//         "updated_at": "2022-10-30T21:40:37.000000Z",
//         "deleted_at": null,
//         "currency": {
//             "id": 1,
//             "code": "AED",
//             "name": "United Arab Emirates Dirham",
//             "created_at": null,
//             "updated_at": null
//         }
//     }
// }