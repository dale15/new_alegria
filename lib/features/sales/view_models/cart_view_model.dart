import 'package:new_alegria/features/sales/models/cart_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_view_model.g.dart';

@riverpod
class CartViewModel extends _$CartViewModel {
  @override
  List<CartItem> build() {
    return [];
  }

  // 🧠 ADD ITEM (MERGE IF EXISTS)
  void addItem(CartItem newItem) {
    final index = state.indexWhere(
      (item) =>
          item.product.id == newItem.product.id &&
          item.selectedOptions.toString() == newItem.selectedOptions.toString(),
    );

    if (index != -1) {
      final updatedItem = state[index].copyWith(
        quantity: state[index].quantity + newItem.quantity,
      );

      state = [
        ...state.sublist(0, index),
        updatedItem,
        ...state.sublist(index + 1),
      ];
    } else {
      state = [...state, newItem];
    }
  }

  // ➕ INCREASE
  void increaseQuantity(CartItem item) {
    final index = state.indexOf(item);
    final updated = item.copyWith(quantity: item.quantity + 1);

    state = [...state]..[index] = updated;
  }

  // ➖ DECREASE
  void decreaseQuantity(CartItem item) {
    final index = state.indexOf(item);

    if (item.quantity <= 1) {
      removeItem(item);
      return;
    }

    final updated = item.copyWith(quantity: item.quantity - 1);
    state = [...state]..[index] = updated;
  }

  // ❌ REMOVE
  void removeItem(CartItem item) {
    state = state.where((e) => e != item).toList();
  }

  // 🧹 CLEAR
  void clear() {
    state = [];
  }

  // 💰 TOTAL (derived state)
  double get total {
    return state.fold(0, (sum, item) => sum + item.totalPrice);
  }
}
