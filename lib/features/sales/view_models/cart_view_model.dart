import 'package:new_alegria/features/sales/models/cart_item.dart';
import 'package:new_alegria/features/sales/models/discount_model.dart';
import 'package:new_alegria/features/sales/models/invoice_request_model.dart';
import 'package:new_alegria/features/sales/models/selected_product_modifier.dart';
import 'package:new_alegria/features/sales/providers/cart_provider.dart';
import 'package:new_alegria/features/sales/view_models/cart_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_view_model.g.dart';

enum PaymentMethod { cash, gcash, card, bankTransfer }

extension PaymentMethodX on PaymentMethod {
  int get apiValue {
    switch (this) {
      case PaymentMethod.cash:
        return 1;
      case PaymentMethod.gcash:
        return 2;
      case PaymentMethod.card:
        return 3;
      case PaymentMethod.bankTransfer:
        return 4;
    }
  }

  String get label {
    switch (this) {
      case PaymentMethod.cash:
        return "Cash";
      case PaymentMethod.gcash:
        return "GCash";
      case PaymentMethod.card:
        return "Card";
      case PaymentMethod.bankTransfer:
        return "Bank Transfer";
    }
  }
}

@riverpod
class CartViewModel extends _$CartViewModel {
  @override
  CartState build() {
    return const CartState();
  }

  Future<List<DiscountModel>> getDiscounts() async {
    return ref.watch(discountRepositoryProvider).getDiscounts();
  }

  bool _isSameOptions(List<SelectedModifier> a, List<SelectedModifier> b) {
    if (a.length != b.length) return false;

    for (int i = 0; i < a.length; i++) {
      if (a[i].modifierName != b[i].modifierName) return false;
      if (a[i].optionName != b[i].optionName) return false;
    }

    return true;
  }

  void applyDiscount(DiscountModel discount) {
    state = state.copyWith(selectedDiscount: discount);
  }

  void removeDiscount() {
    state = state.copyWith(clearDiscount: true);
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

  void clearCart() {
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

  CreateInvoiceRequest buildInvoice() {
    final state = this.state;

    return CreateInvoiceRequest(
      discountId: state.selectedDiscount?.id,
      tax: null,
      discount: state.discountAmount,

      items: state.items.map((item) {
        return InvoiceItem(
          productId: item.product.id,
          quantity: item.quantity,
          modifiers: item.selectedOptions.map((opt) {
            return InvoiceModifier(
              modifierName: opt.modifierName,
              optionName: opt.optionName,
              priceAdjustment: opt.priceAdjustment.toDouble(),
            );
          }).toList(),
        );
      }).toList(),

      payments: [
        Payment(
          paymentMethod: state.paymentMethod.apiValue,
          amount: state.total,
        ),
      ],
    );
  }

  Future<void> createInvoice() async {
    final request = buildInvoice();
    await ref.read(invoiceRepositoryProvider).createInvoice(request);
    clearCart();
  }
}
