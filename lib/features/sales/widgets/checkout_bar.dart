import 'package:flutter/material.dart';
import 'package:new_alegria/features/sales/view_models/cart_state.dart';
import 'package:new_alegria/features/sales/view_models/cart_view_model.dart';
import 'package:new_alegria/features/sales/widgets/checkout_sheet.dart';

class CheckoutBar extends StatelessWidget {
  const CheckoutBar({super.key, required this.cartState, required this.cartVm});

  final CartState cartState;
  final CartViewModel cartVm;

  @override
  Widget build(BuildContext context) {
    final cart = cartState.items;
    final isDisabled = cart.isEmpty;

    void showDiscountPicker(BuildContext context) async {
      // You need access to discounts — simplest way is pass them OR fetch here
      final discounts = await cartVm.getDiscounts(); // implement this in VM

      if (!context.mounted) return;

      showDialog(
        context: context,
        builder: (context) {
          final activeDiscounts = discounts.where((d) => d.isActive).toList();
          final selected = cartState.selectedDiscount;

          return Dialog(
            constraints: BoxConstraints(maxWidth: 600),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// TITLE
                  Row(
                    children: [
                      const Icon(
                        Icons.local_offer,
                        size: 18,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        "Discount",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, size: 18),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// GRID
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 220),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: activeDiscounts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 👈 change to 3 if tablet
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 2.5, // 👈 controls height
                          ),
                      itemBuilder: (_, index) {
                        final discount = activeDiscounts[index];
                        final isSelected = selected?.id == discount.id;

                        return InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            cartVm.applyDiscount(discount);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.orange.withOpacity(0.1)
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.orange
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.local_offer,
                                  size: 14,
                                  color: isSelected
                                      ? Colors.orange
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 6),

                                /// TEXT
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        discount.name,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        discount.type == 'percent'
                                            ? "${discount.value}%"
                                            : "₱${discount.value}",
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                if (isSelected)
                                  const Icon(
                                    Icons.check,
                                    size: 14,
                                    color: Colors.orange,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// ACTIONS
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          cartVm.removeDiscount();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Remove",
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Close",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// DISCOUNT CHIP
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: cartState.selectedDiscount != null
                    ? Colors.orange.withOpacity(0.1)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: cartState.selectedDiscount != null
                      ? Colors.orange
                      : Colors.grey.shade300,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_offer,
                    size: 14,
                    color: cartState.selectedDiscount != null
                        ? Colors.orange
                        : Colors.grey,
                  ),
                  const SizedBox(width: 6),

                  /// CLICKABLE TEXT ONLY
                  GestureDetector(
                    onTap: () => showDiscountPicker(context),
                    child: Text(
                      cartState.selectedDiscount?.name ?? "Add discount",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: cartState.selectedDiscount != null
                            ? Colors.orange
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),

                  /// REMOVE BUTTON
                  if (cartState.selectedDiscount != null) ...[
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        cartVm.removeDiscount();
                      },
                      child: Icon(Icons.close, size: 14, color: Colors.orange),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 6),

            if (cartState.selectedDiscount != null)
              Row(
                children: [
                  Text(
                    "Discount",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const Spacer(),
                  Text(
                    "-₱${cartState.discountAmount.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            Row(
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  '₱${cartState.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isDisabled
                    ? null
                    : () async {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                          ),
                          builder: (_) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(
                                  context,
                                ).viewInsets.bottom,
                              ),
                              child: CheckoutSheet(),
                            );
                          },
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Pay',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
