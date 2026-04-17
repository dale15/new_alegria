class CreateInvoiceRequest {
  final int? discountId;
  final double? tax;
  final double discount;
  final List<InvoiceItem> items;
  final List<Payment> payments;

  CreateInvoiceRequest({
    this.discountId,
    this.tax,
    required this.discount,
    required this.items,
    required this.payments,
  });

  Map<String, dynamic> toJson() {
    return {
      "discountId": discountId,
      "tax": tax,
      "discount": discount,
      "items": items.map((e) => e.toJson()).toList(),
      "payments": payments.map((e) => e.toJson()).toList(),
    };
  }
}

class InvoiceItem {
  final int productId;
  final int quantity;
  final List<InvoiceModifier> modifiers;

  InvoiceItem({
    required this.productId,
    required this.quantity,
    required this.modifiers,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "quantity": quantity,
      "modifiers": modifiers.map((e) => e.toJson()).toList(),
    };
  }
}

class InvoiceModifier {
  final String modifierName;
  final String optionName;
  final double priceAdjustment;

  InvoiceModifier({
    required this.modifierName,
    required this.optionName,
    required this.priceAdjustment,
  });

  Map<String, dynamic> toJson() {
    return {
      "modifierName": modifierName,
      "optionName": optionName,
      "priceAdjustment": priceAdjustment,
    };
  }
}

class Payment {
  final int paymentMethod;
  final double amount;

  Payment({required this.paymentMethod, required this.amount});

  Map<String, dynamic> toJson() {
    return {"paymentMethod": paymentMethod, "amount": amount};
  }
}
