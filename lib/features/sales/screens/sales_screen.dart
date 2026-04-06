import 'package:flutter/material.dart';
import 'package:new_alegria/features/sales/screens/product_screen.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(children: const [Expanded(flex: 2, child: ProductScreen())]),
      ),
    );
  }
}
