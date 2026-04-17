import 'package:new_alegria/features/sales/models/cart_item.dart';
import 'package:new_alegria/features/sales/models/discount_model.dart';
import 'package:new_alegria/features/sales/view_models/cart_view_model.dart';

class CartState {
  final List<CartItem> items;
  final PaymentMethod paymentMethod;
  final double cashReceived;
  final DiscountModel? selectedDiscount;

  const CartState({
    this.items = const [],
    this.paymentMethod = PaymentMethod.cash,
    this.cashReceived = 0,
    this.selectedDiscount,
  });

  CartState copyWith({
    List<CartItem>? items,
    PaymentMethod? paymentMethod,
    double? cashReceived,
    DiscountModel? selectedDiscount,
    bool clearDiscount = false,
  }) {
    return CartState(
      items: items ?? this.items,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      cashReceived: cashReceived ?? this.cashReceived,
      selectedDiscount: clearDiscount
          ? null
          : (selectedDiscount ?? this.selectedDiscount),
    );
  }

  // =========================
  // 💰 COMPUTED VALUES
  // =========================

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);

  double get discountAmount {
    final discount = selectedDiscount;

    if (discount == null || !discount.isActive) return 0;

    if (discount.type == 'percent') {
      return subtotal * (discount.value.toDouble() / 100);
    }

    if (discount.type == 'fixed') {
      return discount.value.toDouble().clamp(0, subtotal);
    }

    return 0;
  }

  double get total => subtotal - discountAmount;

  double get change =>
      paymentMethod == PaymentMethod.cash ? cashReceived - total : 0;
}
