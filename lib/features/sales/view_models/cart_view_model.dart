import 'package:new_alegria/features/sales/models/cart_item.dart';
import 'package:new_alegria/features/sales/view_models/cart_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_view_model.g.dart';

enum PaymentMethod { cash, gcash, card, bankTransfer }

@riverpod
@riverpod
class CartViewModel extends _$CartViewModel {
  @override
  CartState build() {
    return const CartState();
  }

  bool _isSameOptions(List a, List b) {
    if (a.length != b.length) return false;

    for (int i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id) return false;
    }

    return true;
  }

  // =========================
  // 🛒 CART ACTIONS
  // =========================

  void addItem(CartItem newItem) {
    final items = [...state.items];

    final index = items.indexWhere(
      (item) =>
          item.product.id == newItem.product.id &&
          _isSameOptions(item.selectedOptions, newItem.selectedOptions),
    );

    if (index != -1) {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity + newItem.quantity,
      );
    } else {
      items.add(newItem);
    }

    state = state.copyWith(items: items);
  }

  void increaseQuantity(CartItem item) {
    final items = [...state.items];
    final index = items.indexOf(item);

    items[index] = item.copyWith(quantity: item.quantity + 1);

    state = state.copyWith(items: items);
  }

  void decreaseQuantity(CartItem item) {
    final items = [...state.items];
    final index = items.indexOf(item);

    if (item.quantity <= 1) {
      items.remove(item);
    } else {
      items[index] = item.copyWith(quantity: item.quantity - 1);
    }

    state = state.copyWith(items: items);
  }

  void removeItem(CartItem item) {
    state = state.copyWith(items: state.items.where((e) => e != item).toList());
  }

  void clear() {
    state = const CartState();
  }

  // =========================
  // 💳 PAYMENT ACTIONS
  // =========================

  void setPaymentMethod(PaymentMethod method) {
    state = state.copyWith(paymentMethod: method);
  }

  void setCashReceived(double value) {
    state = state.copyWith(cashReceived: value);
  }

  // =========================
  // 🧾 ORDER
  // =========================

  Future<Map<String, dynamic>> createInvoice() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final invoice = {
      "invoiceNumber": DateTime.now().millisecondsSinceEpoch.toString(),
      "total": state.total,
      "items": state.items.length,
    };

    clear();

    return invoice;
  }
}
