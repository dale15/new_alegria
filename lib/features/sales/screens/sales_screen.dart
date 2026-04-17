import 'package:flutter/material.dart';
import 'package:new_alegria/features/sales/screens/product_screen.dart';
import 'package:new_alegria/features/sales/widgets/cart_grid_panel.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Row(
          children: const [
            Expanded(flex: 2, child: ProductScreen()),
            Expanded(flex: 1, child: CartGridPanel()),
          ],
        ),
      ),
    );
  }
}
