import 'package:new_alegria/features/products/models/product_model.dart';
import 'package:new_alegria/features/sales/models/selected_product_modifier.dart';

class CartItem {
  final ProductModel product;
  final List<SelectedModifier> selectedOptions;
  final double extraPrice;
  int quantity;

  CartItem({
    required this.product,
    this.selectedOptions = const [],
    this.extraPrice = 0.0,
    this.quantity = 1,
  });

  // 🧠 COMPUTED: total per item
  double get totalPrice => (product.sellingPrice + extraPrice) * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] is int
          ? json['quantity']
          : int.parse(json['quantity'].toString()),
    );
  }

  CartItem copyWith({
    ProductModel? product,
    List<SelectedModifier>? selectedOptions,
    double? extraPrice,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      extraPrice: extraPrice ?? this.extraPrice,
      quantity: quantity ?? this.quantity,
    );
  }
}
