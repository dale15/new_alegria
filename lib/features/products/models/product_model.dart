import 'package:new_alegria/features/products/models/modifier_model.dart';

class ProductModel {
  final int id;
  final String name;
  final String sku;
  final double sellingPrice;
  final double costPrice;
  final int categoryId;
  final String categoryName;
  final String? imageUrl;
  final List<Modifier> modifiers;

  ProductModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.sellingPrice,
    required this.costPrice,
    required this.categoryId,
    required this.categoryName,
    required this.modifiers,
    this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      sku: json['sku'],
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      costPrice: (json['costPrice'] as num).toDouble(),
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      imageUrl: json['imageUrl'],
      modifiers:
          (json['modifiers'] as List<dynamic>?)
              ?.map((m) => Modifier.fromJson(m))
              .toList() ??
          [],
    );
  }
}
