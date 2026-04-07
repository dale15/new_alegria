import 'package:new_alegria/features/sales/models/cart_item.dart';
import 'package:new_alegria/features/sales/view_models/cart_view_model.dart';

class CartState {
  final List<CartItem> items;
  final PaymentMethod paymentMethod;
  final double cashReceived;

  const CartState({
    this.items = const [],
    this.paymentMethod = PaymentMethod.cash,
    this.cashReceived = 0,
  });

  CartState copyWith({
    List<CartItem>? items,
    PaymentMethod? paymentMethod,
    double? cashReceived,
  }) {
    return CartState(
      items: items ?? this.items,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cashReceived: cashReceived ?? this.cashReceived,
    );
  }

  // =========================
  // 💰 COMPUTED VALUES
  // =========================

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);

  double get discountAmount => 0;

  double get total => subtotal - discountAmount;

  double get change =>
      paymentMethod == PaymentMethod.cash ? cashReceived - total : 0;
}
