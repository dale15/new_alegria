import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_alegria/features/sales/models/cart_item.dart';
import 'package:new_alegria/features/sales/view_models/cart_state.dart';
import 'package:new_alegria/features/sales/view_models/cart_view_model.dart';
import 'package:new_alegria/features/sales/widgets/checkout_bar.dart';

class CartGridPanel extends ConsumerWidget {
  const CartGridPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartViewModelProvider);
    final cartVm = ref.read(cartViewModelProvider.notifier);

    final cart = cartState.items;

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _cartHeader(cartState, cartVm),
              const SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: cart.isEmpty
                      ? Center(
                          child: Text(
                            'Tap a product to add it here',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        )
                      : _cartList(cart, cartVm),
                ),
              ),
            ],
          ),

          /// STICKY CHECKOUT BAR
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CheckoutBar(cartState: cartState, cartVm: cartVm),
          ),
        ],
      ),
    );
  }

  Widget _cartHeader(CartState cartState, CartViewModel cartVm) {
    final cart = cartState.items;

    return Column(
      children: [
        Row(
          children: [
            Row(
              children: const [
                Icon(Icons.shopping_cart_outlined, size: 20),
                SizedBox(width: 6),
                Text('Cart'),
              ],
            ),
            const Spacer(),

            TextButton.icon(
              onPressed: cart.isEmpty ? null : cartVm.clearCart,
              icon: const Icon(Icons.delete_outline, size: 18),
              label: const Text('Clear'),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// TOTAL + COUNT
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${cart.length} items',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            Text(
              '₱${cartState.subtotal}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _cartList(List<CartItem> cart, CartViewModel cartVm) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: cart.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final item = cart[i]; // 👈 missing line

        return Dismissible(
          key: ValueKey(item.product.id),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => cartVm.removeItem(item),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: _CartItemTile(item: item, cartVm: cartVm),
        );
      },
    );
  }
}

class _CartItemTile extends StatelessWidget {
  const _CartItemTile({required this.item, required this.cartVm});

  final CartItem item;
  final CartViewModel cartVm;

  String formatOptions(List options) {
    return options
        .map((e) {
          final price = e.priceAdjustment;

          if (price > 0) {
            return '${e.name} (+₱${price.toStringAsFixed(2)})';
          } else if (price < 0) {
            return '${e.name} (-₱${price.abs().toStringAsFixed(2)})';
          }

          return e.name;
        })
        .join(' • ');
  }

  @override
  Widget build(BuildContext context) {
    final optionsLabel = item.selectedOptions.isEmpty
        ? null
        : formatOptions(item.selectedOptions);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          /// LEFT: Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),

                if (optionsLabel != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    optionsLabel,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                  ),
                ],

                const SizedBox(height: 6),

                Text(
                  '₱${item.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          /// CENTER: Quantity Controls
          Row(
            children: [
              IconButton(
                onPressed: () => cartVm.decreaseQuantity(item),
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text(
                '${item.quantity}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: () => cartVm.increaseQuantity(item),
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),

          /// RIGHT: Remove
          // IconButton(
          //   onPressed: () => cartVm.removeItem(item),
          //   icon: const Icon(Icons.close),
          // ),
        ],
      ),
    );
  }
}
