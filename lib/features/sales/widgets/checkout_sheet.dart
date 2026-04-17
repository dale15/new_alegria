import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_alegria/features/sales/view_models/cart_state.dart';
import 'package:new_alegria/features/sales/view_models/cart_view_model.dart';

class CheckoutSheet extends ConsumerStatefulWidget {
  const CheckoutSheet({super.key});

  @override
  ConsumerState<CheckoutSheet> createState() => _CheckoutSheetState();
}

class _CheckoutSheetState extends ConsumerState<CheckoutSheet> {
  final TextEditingController _cashController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartViewModelProvider);
    final cartVm = ref.read(cartViewModelProvider.notifier);

    final subtotal = cartState.subtotal;
    final discount = cartState.discountAmount;
    final total = cartState.total;
    final change = cartState.change;
    final paymentMethod = cartState.paymentMethod;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            const Text(
              "Checkout",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            /// Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _buildRow("Subtotal", subtotal),

                  if (discount > 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: _buildRow(
                        "Discount",
                        -discount,
                        valueColor: Colors.green,
                      ),
                    ),

                  const Divider(height: 24),

                  _buildRow("Total", total, isBold: true, fontSize: 18),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Payment Method
            const Text(
              "Payment Method",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildPaymentButton(
                    context,
                    cartVm,
                    paymentMethod,
                    PaymentMethod.cash,
                    "💵 Cash",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildPaymentButton(
                    context,
                    cartVm,
                    paymentMethod,
                    PaymentMethod.gcash,
                    "📱 GCash",
                  ),
                ),
              ],
            ),

            /// Cash Input
            if (paymentMethod == PaymentMethod.cash) ...[
              const SizedBox(height: 20),

              TextField(
                controller: _cashController,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Cash Received",
                  prefixText: "₱ ",
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  cartVm.setCashReceived(double.tryParse(value) ?? 0);
                },
              ),

              const SizedBox(height: 16),

              /// Change Box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: change >= 0
                      ? Colors.green.shade50
                      : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: _buildRow(
                  "Change",
                  change < 0 ? 0 : change,
                  valueColor: change >= 0 ? Colors.green : Colors.red,
                  isBold: true,
                ),
              ),
            ],

            const SizedBox(height: 24),

            /// Confirm Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _canConfirm(cartState)
                    ? () => _processOrder(context, cartVm)
                    : null,
                child: const Text(
                  "Confirm Payment",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canConfirm(CartState state) {
    if (state.paymentMethod == PaymentMethod.cash) {
      return state.cashReceived >= state.total;
    }
    return true;
  }

  Future<void> _processOrder(BuildContext context, CartViewModel cartVm) async {
    try {
      await cartVm.createInvoice();
      if (!context.mounted) return;

      Navigator.pop(context);
    } catch (e) {
      debugPrint("Order failed: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Order failed: $e")));
    }
  }

  Widget _buildRow(
    String label,
    double value, {
    bool isBold = false,
    double fontSize = 14,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
          ),
        ),
        Text(
          "₱${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
  // Color.fromARGB(255, 241, 66, 45)

  Widget _buildPaymentButton(
    BuildContext context,
    CartViewModel cartVm,
    PaymentMethod selected,
    PaymentMethod method,
    String label,
  ) {
    final isSelected = selected == method;

    return GestureDetector(
      onTap: () => cartVm.setPaymentMethod(method),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
