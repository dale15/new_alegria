import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_alegria/features/products/models/product_model.dart';
import 'package:new_alegria/features/products/view_models/product_state.dart';
import 'package:new_alegria/features/products/view_models/product_view_model.dart';

class ProductScreen extends ConsumerWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productViewModelProvider);
    final vm = ref.read(productViewModelProvider.notifier);

    return Column(
      children: [
        _buildHeader(vm),
        _buildSearchBar(vm),
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: _buildCategoryChips(vm, state),
        ),
        Expanded(child: _buildProductGrid(vm)),
      ],
    );
  }

  Widget _buildHeader(ProductViewModel vm) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Alegria Bakeshop",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(vm.formattedDate, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ProductViewModel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onChanged: vm.setSearchQuery,
        decoration: InputDecoration(
          hintText: "Search products...",
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildCategoryChips(ProductViewModel vm, ProductState state) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = vm.categories[index];
          final isSelected = category == state.selectedCategory;

          return ChoiceChip(
            label: Text(category),
            selected: isSelected,
            selectedColor: Colors.orange.shade100,
            labelStyle: TextStyle(
              color: isSelected ? Colors.orange : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            onSelected: (_) => vm.selectCategory(category),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: vm.categories.length,
      ),
    );
  }

  Widget _buildProductGrid(ProductViewModel vm) {
    final products = vm.filteredProducts;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 👈 adjust for POS layout
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return _buildProductCard(product, vm);
      },
    );
  }

  Widget _buildProductCard(ProductModel product, ProductViewModel vm) {
    return GestureDetector(
      onTap: () {
        // next: add to cart
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.local_cafe,
              size: 40,
            ), // 👈 better for coffee/bakery
            Text(
              product.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              "₱${product.sellingPrice}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
