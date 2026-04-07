import 'package:flutter/material.dart';
import 'package:new_alegria/features/sales/models/cart_item.dart';
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

    return Container(
      padding: const EdgeInsets.all(16),
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
        child: Row(
          children: [
            /// TOTAL
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
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
            ),

            /// PAY BUTTON
            ElevatedButton(
              onPressed: isDisabled
                  ? null
                  : () async {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (_) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: CheckoutSheet(),
                          );
                        },
                      );
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Pay', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
