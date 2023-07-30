class PaymentMethodModel {
  final int id;
  final String name;
  final String? createdAt;
  final String? updatedAt;
  PaymentMethodModel({
    required this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  String toString() {
    return 'PaymentMethodModel(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
